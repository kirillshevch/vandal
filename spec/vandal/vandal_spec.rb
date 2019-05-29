require 'spec_helper'

RSpec.describe Vandal::Destroy do
  describe '#vandal_destroy' do
    let!(:user) { create(:user) }
    let!(:posts) { create_list(:post, 3, user: user) }
    let!(:comments) { create_list(:comment, 3, post: posts.last) }

    it 'should destroy all related data' do
      user.vandal_destroy

      expect(User.count).to eq(0)
      expect(Post.count).to eq(0)
      expect(Comment.count).to eq(0)
    end
  end

  describe '#vandal_destroy_all' do
    let!(:users) { create_list(:user, 3) }
    let!(:posts) { create_list(:post, 3, user: users.last) }
    let!(:comments) { create_list(:comment, 3, post: posts.last) }

    it 'should destroy all related data' do
      User.all.vandal_destroy_all

      expect(User.count).to eq(0)
      expect(Post.count).to eq(0)
      expect(Comment.count).to eq(0)
    end
  end
end
