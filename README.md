# The Fork Test

## Project Description
This a simple application that shows only one screen. This screen has a TableView, a Sort button and a Heart Icon button on each restaurant for adding or removing from favorites. The Table View display a list of restaurants with some basic information, like photo, name, rating and address.

## Architecture
I decided to use Clean+MVVM architecture. Although the project is very simple, this architecture is useful for larger projects where scalability is a requirement. The separation of layers is extremely good for UI Testing and Unit Testing, I've added both UI and Unit tests as an example.

Very short explanation about layer responsibilities. 
MVVM connect the View with the ViewModel, and the ViewModel connects with Use Cases and back again with the View.
The Clean Architecture is presented by Use Cases and Repositories layers. The Use Cases have all business logic and is connected with both View Model and Repository. Lastly, the Repository layer is in charge of fetching data, from a API Request or any other data source (Core Data, Keychain, User Defaults, Json files, etc).

## How to Install and Run the Project
1. Create a folder with any name you want
2. Inside your folder clone the repository:
  ### git clone https://github.com/diegotubito/theFork.git
3. You are good to go :)
