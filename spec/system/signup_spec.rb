require 'rails_helper'

RSpec.describe 'SignUp', type: :system do
    before do
      ActionMailer::Base.deliveries.clear
    end