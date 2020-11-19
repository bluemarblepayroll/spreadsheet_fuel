# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe SpreadsheetFuel::Library::Serialize::Xlsx do
  let(:output)   { Burner::Output.new(outs: [StringIO.new]) }
  let(:register) { 'register_a' }
  let(:path)     { File.join('temp', 'spec', "#{SecureRandom.uuid}.xlsx") }

  let(:config) do
    {
      name: 'test_job',
      register: register,
      sheet_mappings: sheet_mappings
    }
  end

  let(:patient_rows) do
    [
      %w[chart_number first_name last_name],
      [123, 'Bozo', 'Clown'],
      ['A456', nil, 'Rizzo'],
      %w[Z789 Hops Bunny]
    ]
  end

  let(:note_rows) do
    [
      %w[emp_number note_number contents],
      ['A456', 1, 'Hello world!'],
      [nil, 2, 'Hello, again!'],
      ['Z789', 1, 'Something something…']
    ]
  end

  let(:patients_register)      { 'patients_register' }
  let(:notes_register)         { 'notes_register' }

  let(:payload) do
    Burner::Payload.new(
      registers: {
        register => patient_rows,
        patients_register => patient_rows,
        notes_register => note_rows
      }
    )
  end

  subject { described_class.make(config) }

  describe '#perform' do
    before(:each) do
      subject.perform(output, payload)
    end

    context 'when sheet_mappings are not specified' do
      let(:sheet_mappings) { nil }

      it 'will use the data in the input register and place it in Sheet1' do
        contents = payload[register]

        io     = StringIO.new(contents)
        book   = Roo::Excelx.new(io)

        actual_patients = book.sheet('Sheet1').to_a
        expect(actual_patients).to eq(patient_rows)
      end
    end

    context 'when sheet_mappings are specified' do
      let(:patients_sheet) { 'Patients' }
      let(:notes_sheet)    { 'Notes' }

      let(:sheet_mappings) do
        [
          { sheet: patients_sheet, register: patients_register },
          { sheet: notes_sheet,    register: notes_register }
        ]
      end

      specify 'rows are serialized into xlsx document' do
        contents = payload[register]

        io     = StringIO.new(contents)
        book   = Roo::Excelx.new(io)

        actual_patients = book.sheet(patients_sheet).to_a
        expect(actual_patients).to eq(patient_rows)

        actual_notes = book.sheet(notes_sheet).to_a
        expect(actual_notes).to eq(note_rows)
      end
    end
  end
end
