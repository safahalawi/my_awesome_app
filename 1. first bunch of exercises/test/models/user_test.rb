# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create({
                          first_name: 'Rami',
                          last_name: 'Rizk',
                          email: 'ram@gtlogic.com'
                        })
  end

  test 'getting the full name' do
    assert_equal 'Rami Rizk', @user.full_name
  end

  test 'setting the full name' do
    @user.full_name = 'Teddy Zeenny'
    assert_equal 'Teddy', @user.first_name
    assert_equal 'Zeenny', @user.last_name
  end

  test 'first name validation' do
    assert @user.valid?
    @user.first_name = nil
    assert @user.invalid?
    assert_equal @user.errors[:first_name].length, 1
    assert @user.errors[:first_name].include?("can't be blank")
  end

  test 'last name validation' do
    assert @user.valid?
    @user.last_name = nil
    assert @user.invalid?
    assert_equal @user.errors[:last_name].length, 1
    assert @user.errors[:last_name].include?("can't be blank")
  end

  test 'email validation' do
    assert @user.valid?
    @user.email = nil
    assert @user.invalid?
    assert_equal @user.errors[:email].length, 2
    assert @user.errors[:email].include?("can't be blank")

    @user.email = 'rami'
    assert @user.invalid?
    assert_equal @user.errors[:email].length, 1
    assert @user.errors[:email].include?('is invalid')

    @user.email = 'rami@gtlogic.com'
    @second_user = User.create({
                                 first_name: 'Safa',
                                 last_name: 'Halawi',
                                 email: 'rami@gtlogic.com'
                               })
    @second_user.save
    assert @second_user.invalid?
    assert_equal @second_user.errors[:email].length, 1
    assert @second_user.errors[:email].include?('has already been taken')
  end
end
