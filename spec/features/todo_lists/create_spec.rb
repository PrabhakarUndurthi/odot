require 'spec_helper'


describe "Creating todos" do
  it "redirects to the index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "I am going to buy groceries today"
    click_button "Create Todo list"

    expect(page).to have_content("My todo list")
  end

  it "displays an error if the todo_list has no title" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title",  with: ""
    fill_in "Description", with: "I am going to buy groceries today"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)


    visit "/todo_lists"
    expect(page).to_not have_content("I am going to buy groceries today")
  end

  it "title must be more than 3 characters" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "hi"
    fill_in "Description", with: "I am going to buy groceries today"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("I am going to buy groceries today")
  end

  it "desciption can not be blank" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "my todo list"
    fill_in "Description", with: ""
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("my todo list")
  end

  it "description must be more than 5 characters" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "Grocery list"
    fill_in "Description", with: "less"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Grocery list")
  end
end
