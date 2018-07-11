require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context 'association' do
    it { should have_and_belong_to_many(:businesses) }
  end

  context 'database columns' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
  end

  context 'objects creation' do
    context 'when name attribute is supplied' do
      it 'is valid' do
        expect(build(:category)).to be_valid
      end

      it 'creates a record in database' do
        create(:category)
        expect(Category.count).to eq(1)
      end
    end

    context 'when name is not supplied' do
      let(:category) { build(:category, name: '') }
      let(:errors) { category.errors[:name] }

      it 'is not valid' do
        expect(category).not_to be_valid
      end

      it 'will add errors for attribute name' do
        expect(errors).not_to be_nil
      end
    end
  end
end
