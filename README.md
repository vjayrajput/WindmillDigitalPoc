# windmill_digital_poc

# Cryptocurrency App

## Project Overview Description

This Flutter application lists cryptocurrencies using the CoinMarketCap API and allows users to add/remove cryptocurrencies to/from favorites. The app supports features like pagination, pull-to-refresh, data caching, and local storage.


## Features

- **Cryptocurrency Listing**: The home screen displays a list of the current cryptocurrencies, fetched from the CoinMarketCap API.
- **Detailed View**: Clicking on a cryptocurrency item navigates to a screen with detailed information about the selected cryptocurrency, such as platform, first historical data, last historical data, etc.
- **Add to Favorites**: On the detailed view screen, a button allows users to add the cryptocurrency to their favorites.
- **Favorites Tab**: A separate tab allows users to view their favorite cryptocurrencies. Clicking on a favorite item opens the detailed view for that cryptocurrency.
- **Remove from Favorites**: On the detailed view of a favorite cryptocurrency, a button allows users to remove it from their favorites.
- **Pull to Refresh**: The cryptocurrency list on the main screen supports pull-to-refresh functionality to update the list with the latest data.

## API Integration

- **CoinMarketCap API**: The app fetches the latest cryptocurrency data using the CoinMarketCap API. Please ensure you have an API key and include it in your cryptocurrency_repository.dart file.
  https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyMap


## Architecture

The app is organized into layers that separate the business logic, data management, and
presentation. This modular approach enhances maintainability and allows for easier testing of
individual components. This project follows a clean architecture pattern, separating the application
into layers:

- **Presentation Layer**: Responsible for the UI components.
  In this app, Flutter widgets represent the UI, and the BLoC manages the state and
  handles user interactions.
- **Domain Layer**: Contains the business logic of the application. It defines use cases and
  entities, ensuring that business rules are followed. This layer is independent of any external
  dependencies.
- **Data Layer**: Handles data retrieval and storage, utilizing local data sources.
- **BLoC Pattern**: The BLoC pattern is employed to manage state and business logic. Each BLoC
  listens for events and emits states, allowing the UI to react to changes seamlessly. The use of
  streams enables a reactive programming model, making it easier to handle asynchronous data and
  user interactions.
  BLoCs are decoupled from the UI, ensuring that the presentation layer is clean and focused solely
  on rendering views.


## Screenshots

<table>
  <tr>
    <td align="center"><img src="https://github.com/vjayrajput/WindmillDigitalPoc/blob/readme_file/screenshots/Screenshot_20241003_075350.png" alt="Screenshot 1" width="350"/></td>
    <td align="center"><img src="https://github.com/vjayrajput/WindmillDigitalPoc/blob/readme_file/screenshots/Screenshot_20241003_075416.png" alt="Screenshot 3" width="350"/></td>
    </tr>
<tr>
   <td align="center"><img src="https://github.com/vjayrajput/WindmillDigitalPoc/blob/readme_file/screenshots/Screenshot_20241003_075434.png" alt="Screenshot 4" width="350"/></td>
   <td align="center"><img src="https://github.com/vjayrajput/WindmillDigitalPoc/blob/readme_file/screenshots/Screenshot_20241003_075502.png" alt="Screenshot 5" width="350"/></td>
</tr>
</table>

## Videos

<video src="https://github.com/user-attachments/assets/9a031017-69a2-4f44-88d2-e04159b682a2" width="300" />

## License

This project is licensed under the MIT License. See the LICENSE file for more information.

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please fork the repository
and submit a pull request.

## Acknowledgments

- Flutter framework
- BLoC library
- Clean architecture principles


