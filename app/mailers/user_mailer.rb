class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.post_created.subject
  #
  def post_created(user, book)
    @book = book
    @user = user
    mail(
      :to => @user.email,
      :subject => @book.title + 'is overdue!'
    )
  end

  def book_notify(user, book)
    @book = book
    @user = user
    mail(
      :to => @user.email,
      :subject => 'We will notify you when ' + @book.title + ' is in stock!'
    )
  end


end
