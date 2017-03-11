require 'rails_helper'

describe Tag do
  let(:tag) { FactoryGirl.build :tag }

  describe 'Tag validation' do
    let(:tag_with_no_params) { Tag.new() }
    let(:tag_with_no_name) { Tag.new(user_id: 1) }
    let(:tag_with_no_user_id) { Tag.new(name: "Tag1") }
    let(:barely_long_name) { Array.new(20){[*0..1].sample}.join }
    let(:long_name) { Array.new(21){[*0..1].sample}.join }
    context 'passed the validation' do
      it 'saves the tag' do
        expect(tag.save).to be_truthy
      end

      it 'saves the tag with title less than 21' do
        tag_with_barely_long_name = Tag.new(user_id: 1, name: barely_long_name)
        expect(tag_with_barely_long_name.save).to be_truthy
      end
    end

    context 'did not pass the validation' do
      it 'fails to save the tag with no params' do
        expect(tag_with_no_params.save).to be_falsey
      end

      it 'fails to save the tag with no name' do
        expect(tag_with_no_name.save).to be_falsey
      end

      it 'fails to save the tag with no user association' do
        expect(tag_with_no_user_id.save).to be_falsey
      end

      it 'fails to save the tag with name longer than 20' do
        tag_with_long_name = Tag.new(user_id: 1, name: long_name)
        expect(tag_with_long_name.save).to be_falsey
      end
    end
  end
end
