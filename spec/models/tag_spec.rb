require 'rails_helper'

describe Tag do
  let(:tag) { FactoryGirl.build :tag }

  describe '#validation' do
    let(:tag_with_params) { Tag.new(params) }

    context 'when given the correct params' do
      let(:barely_long_name) { Array.new(20){[*0..1].sample}.join }
      let(:params) { {user_id: 1, name: barely_long_name} }
      it 'is valid' do
        expect(tag).to be_valid
      end

      it 'is valid with title less than 51 words' do
        expect(tag_with_params).to be_valid
      end
    end

    context 'when given the empty params' do
      let(:params) { {} }
      it 'is invalid' do
        expect(tag_with_params).to be_invalid
      end
    end

    context 'when given no name' do
    let(:params) { {user_id: 1} }
      it 'is invalid' do
        expect(tag_with_params).to be_invalid
      end
    end

    context 'when given the wrong params' do
      let(:long_name) { Array.new(21){[*0..1].sample}.join }
      let(:params) { {user_id: 1, name: long_name} }
      it 'is invalid with title longer than 50 words' do
        expect(tag_with_params).to be_invalid
      end
    end
  end
end
