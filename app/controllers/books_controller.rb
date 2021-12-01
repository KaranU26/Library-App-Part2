class BooksController < ApplicationController

    
    def index
        @allbooks = Book.all
        @user = current_user 

    end

    def neighborbranch
        @allbooks = Book.where(branchname: "Neighbourhood Branch")
        @user = current_user 
    end

    def downtownbranch
        @allbooks = Book.where(branchname: "Downtown Branch")
        @user = current_user 
    end

    def suburbsbranch
        @allbooks = Book.where(branchname: "Suburbs Branch")
        @user = current_user 
    end

    def bookDetails
        @bookid = Book.find(params[:id])
        @title = @bookid.title
        #render 'bookDetails'
    end

    def mybooks
        @user = current_user
        @allmybooks = @user.books
        #render 'mybooks'
    end

    def adminaccess
        @allbooks = Book.all
        @user = current_user
        if @user.admin?
            render 'admin'

        end
    end

    #method used by the admin that will use a form to edit the contents of a book.
    def update
        @editbook = Book.find(params[:id])
        @editbook.update(title: params[:book][:title], author: params[:book][:author], genre: params[:book][:genre], sub_genre: params[:book][:sub_genre], pages: params[:book][:pages], publisher: params[:book][:publisher], copies: params[:book][:copies])
    end

    #method used to edit the specifically selected book by the admin
    def edit
        @editbook = Book.find(params[:id])
    end

    def notify
        @booktonotify = Book.find(params[:id])
        @user = current_user
        UserMailer.book_notify(@user, @booktonotify).deliver_now 
    end 

    def checkout
        @book1 = Book.find(params[:id])
        @user = current_user
        
        if @user.books.find_by_id(@book1)
            flash[:alert] = "Book already checked out!"
        else
            @book1ref = @book1
            @book1ref.checkoutdate = Date.today
            @user.books << @book1ref
            @book1.copies = @book1.copies.to_i - 1 #copies not subtracting for some reason
            @book1.save
        end
        @currentdate = Date.today
        @user.books.each do |usercheck|
            puts usercheck.checkoutdate
            @latedate = usercheck.checkoutdate + 7.days
            if @currentdate >= @latedate
                UserMailer.post_created(@user, @book1).deliver_now       
            end
        end
    end
    
    def return
        @booktoreturn = Book.find(params[:id])
        @user = current_user
        @booktoreturn.copies = @booktoreturn.copies + 1
        @booktoreturn.save
        @user.books.delete(Book.find(@booktoreturn.id))
    end
    
    private
    
    def book_params
        params.require(:book).permit(:title, :author, :genre, :sub_genre, :pages, :publisher, :copies)
    end
end