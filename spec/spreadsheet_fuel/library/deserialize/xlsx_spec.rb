# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe SpreadsheetFuel::Library::Deserialize::Xlsx do
  let(:output)   { Burner::Output.new(outs: [StringIO.new]) }
  let(:register) { 'register_a' }
  let(:path)     { File.join('spec', 'fixtures', 'patients_and_notes.xlsx') }
  let(:contents) { File.open(path, &:read) }

  let(:config) do
    {
      name: 'test_job',
      register: register,
      sheet_mappings: sheet_mappings
    }
  end

  let(:payload) do
    Burner::Payload.new(
      registers: {
        register => contents
      }
    )
  end

  subject { described_class.make(config) }

  describe '#perform' do
    before(:each) do
      subject.perform(output, payload)
    end

    context 'when sheet_mappings are specified' do
      let(:patients_register) { 'patients_register' }
      let(:notes_register)    { 'notes_register' }

      let(:sheet_mappings) do
        [
          { sheet: 'Patients', register: patients_register },
          { sheet: 'Notes',    register: notes_register },
          { sheet: 'Patients', register: register } # should overwrite input register
        ]
      end

      specify 'specified payload registers contains their sheets respective data' do
        expected_patients = [
          %w[chart_number first_name last_name],
          [123, 'Bozo', 'Clown'],
          ['A456', nil, 'Rizzo'],
          %w[Z789 Hops Bunny]
        ]

        expected_notes = [
          %w[emp_number note_number contents],
          ['A456', 1, 'Hello world!'],
          [nil, 2, 'Hello, again!'],
          ['Z789', 1, 'Something something…']
        ]

        expect(payload[patients_register]).to eq(expected_patients)
        expect(payload[notes_register]).to    eq(expected_notes)
        expect(payload[register]).to          eq(expected_patients)
      end
    end

    context 'when sheet_mappings are not specified' do
      let(:sheet_mappings) { nil }

      specify 'output contains default sheet verbiage' do
        summary = output.outs.first.string

        expect(summary).to include('the default sheet')
      end

      specify 'output contains number of records' do
        summary = output.outs.first.string

        expect(summary).to include('4 record(s)')
      end

      specify 'payload register has data' do
        value = payload[register]

        expected = [
          %w[chart_number first_name last_name],
          [123, 'Bozo', 'Clown'],
          ['A456', nil, 'Rizzo'],
          %w[Z789 Hops Bunny]
        ]

        expect(value).to eq(expected)
      end
    end
  end
end
