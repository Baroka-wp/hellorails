require 'rails_helper'

RSpec.describe Like, type: :model do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Title', text: 'Body', user_id: user.id)
    subject { Like.new(post_id: post.id, user_id: user.id) }
    before { subject.save }

    context 'validations' do
        it 'is valid with valid attributes' do
            expect(subject).to be_valid
        end
        it 'is not valid without a post_id' do
            subject.post_id = nil
            expect(subject).to_not be_valid
        end
        it 'is not valid without a user_id' do
            subject.user_id = nil
            expect(subject).to_not be_valid
        end
    end
    context 'associations' do
        it 'belongs to a post' do
            assc = described_class.reflect_on_association(:post)
            expect(assc.macro).to eq :belongs_to
        end
        it 'belongs to a user' do
            assc = described_class.reflect_on_association(:user)
            expect(assc.macro).to eq :belongs_to
        end
    end
    context 'Costum methods' do
        it 'not update post like count' do
            expect(subject.post.likesCounter).to eq(0)
        end
        it 'update post like count' do
            subject.update_like_counter
            expect(subject.post.likesCounter).to eq(1)
        end
    end
end