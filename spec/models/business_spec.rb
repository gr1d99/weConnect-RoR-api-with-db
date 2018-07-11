require 'rails_helper'

RSpec.describe Business, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context 'association' do
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:locations) }
  end

  context 'database columns' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:name) }
  end

  context 'object creation' do
    context 'when name is provided' do
      let(:business) { build(:business) }

      it 'is valid' do
        expect(business).to be_valid
      end

      it 'creates a record in database' do
        create(:business)
        expect(Business.count).to eq(1)
      end
    end

    context 'when name is not provided' do
      let(:business) { build(:business) }

      it 'is adds error for attribute name' do
        business.valid?
        expect(business.errors[:name]).not_to be(blank?)
      end
    end
  end

  context 'associated object creation' do
    before do
      create(:business)
    end

    let(:business) { Business.first }

    it 'creates locations' do
      expect(Business.count).to eq(1)
      expect(Location.count).to eq(0)
      expect(business).not_to be_nil

      business.locations.create(address: Faker::Address.full_address)

      expect(business.locations.count).to eq(1)
      expect(Location.count).to eq(1)
    end

    it 'creates categories' do
      expect(Business.count).to eq(1)
      expect(Category.count).to eq(0)
      expect(business).not_to be_nil

      business.categories.create(name: 'some category')

      expect(business.categories.count).to eq(1)
    end
  end
end
