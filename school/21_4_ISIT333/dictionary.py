# Matt Graham
# ISIT 333 - Lab 7 Part 1
# 11/10/2021

# TODO
# run code
# create a function to list all books
# make sure it works
# comment
# -------------- example output for list
# Command: list
#
# Title:    Slaughterhouse Five
# Author:   Kurt Vonnegut
# Pub Year: 1969


def list_books(book_catalog):
    # iterate through all titles in the catalog
    for title in book_catalog:
        # set book to title item
        book = book_catalog[title]
        # print all book items
        print("Title:    " + title)
        print("Author:   " + book["author"])
        print("Pub year: " + book["pubyear"])
        print()


def show_book(book_catalog):
    # get user's book title
    title = input("Title: ")
    # search through book catalog
    if title in book_catalog:
        book = book_catalog[title]
        print("Title:    " + title)
        print("Author:   " + book["author"])
        print("Pub year: " + book["pubyear"])
    else:
        print("Sorry, " + title + " doesn't exist in the catalog.")


def add_edit_book(book_catalog, mode):
    # get user's target book title
    title = input("Title: ")
    # if mode is add, check to make sure book does not exist. Otherwise, add the book
    if mode == "add" and title in book_catalog:
        print(title + " already exists in the catalog.")
        response = input("Would you like to edit it? (y/n): ").lower()
        if response != "y":
            return
    # if mode is edit, and book does not exist, ask user if they want to add
    elif mode == "edit" and title not in book_catalog:
        print(title + " doesn't exist in the catalog.")
        response = input("Would you like to add it? (y/n): ").lower()
        if response != "y":
            return

    # get author and pubyear
    author = input("Author name: ")
    pubyear = input("Publication year: ")

    # Create a dictionary for the book data
    book = {"author": author,
            "pubyear": pubyear}

    # Add the book data to the catalog using title as key
    book_catalog[title] = book


def delete_book(book_catalog):
    # get user's desired book title
    title = input("Title: ")
    # it match, delete
    if title in book_catalog:
        del book_catalog[title]
        print(title + " removed from catalog.")
    else:
        print(title + " doesn't exist in the catalog.")


def display_menu():
    print("The Book Catalog program")
    print()
    print("COMMAND MENU")
    print("list - Show all book info")
    print("show - Show book info")
    print("add -  Add book")
    print("edit - Edit book")
    print("del -  Delete book")
    print("exit - Exit program")


def main():
    display_menu()
    # set definition
    book_catalog = {
        "Moby Dick":
            {"author": "Herman Melville",
             "pubyear": "1851"},
        "The Hobbit":
            {"author": "J. R. R. Tolkien",
             "pubyear": "1937"},
        "Slaughterhouse Five":
            {"author": "Kurt Vonnegut",
             "pubyear": "1969"}
    }
    while True:
        print()
        # get user input
        command = input("Command: ").lower()
        if command == "list":
            list_books(book_catalog)
        elif command == "show":
            show_book(book_catalog)
        elif command == "add":
            add_edit_book(book_catalog, mode="add")
        elif command == "edit":
            add_edit_book(book_catalog, mode="edit")
        elif command == "del":
            delete_book(book_catalog)
        elif command == "exit":
            print("Bye!")
            break
        else:
            print("Unknown command. Please try again.")


if __name__ == "__main__":
    main()
