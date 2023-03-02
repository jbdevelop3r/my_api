module Api 
    module V1 
        class BooksController < ApplicationController  

            def index 
                books = Book.all
                render json: {status: "success", message: "Loaded all books available", data: books}, status: :ok
            end

            def show 
                book = Book.find(params[:id])
                render json: {status: "success", message: "Loaded single book", data:book}, status: :ok
            end 
            
            def create
                book = Book.new(book_params)

                if book.save
                    render json: {status: "success", message: "Create a book with id #{book.id}", data: book}, status: :ok
                else
                    render json: {status: "error", message: "Failed to create a book", data: book.errors}, status: :unprocessable_entity
                end 
            end

            def update 
                book = Book.find(params[:id])
                if book.update(book_params)
                    render json: {status: "success", message: "Book #{book.id} has been updated", data:book}, status: :ok
                else 
                    render json: {status: "error", message: "Unable to update book #{book.id}", data:book.errors}, status: :unprocessable_entity
                end
            end

            def destroy 
                book = Book.find(params[:id])
                book.destroy
                render json: {status: "success", message: "Book #{book.title} has been deleted"}, status: :ok
            end


            private 
            def book_params
                params.permit(:title, :description)
            end

        end
    end
end