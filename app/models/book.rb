class Book < ApplicationRecord
    has_many :user_books
    has_many :users, :through => :user_books
    has_many :branches_books
    has_many :branches, :through => :branches_books
    serialize :checkedoutusers, Array
end
