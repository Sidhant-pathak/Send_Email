class UserMailer < ApplicationMailer
    def welcome_email(user)
        # @user = user
        # mail(to: @user.email, subject: 'Welcome to My Awesome Site')

        if @user.present?
            mail(to: @user.email, subject: 'Welcome to My Awesome Site')
          else
            # handle the case where @user is nil
        end
    end
end
