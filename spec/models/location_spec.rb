require 'rails_helper'

RSpec.describe Location, type: :model do
  context 'validations' do
    it { should validate_presence_of(:address) }
  end

  context 'database columns' do
    it { should have_db_column(:address).of_type(:string) }
  end

  context 'object creation' do
    context 'when address is provided' do
      let(:location) { build(:location) }

      it 'is valid' do
        expect(location).to be_valid
      end

      it 'creates a record in database' do
        location.save
        expect(Location.count).to eq(1)
      end
    end

    context 'when address is not provided' do
      let(:location) { build(:location, address: '') }

      it 'is invalid' do
        expect(location).not_to be_valid
      end

      it 'adds error message for attribute address' do
        location.save
        expect(location.errors[:address].blank?).not_to be_truthy
      end

      it 'does not create a new record in database' do
        location.save
        expect(Location.count).to eq(0)
      end
    end
  end
end
