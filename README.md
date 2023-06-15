# Posted - Instagram-like App

[![Android Release](https://github.com/izier/posted/actions/workflows/dart.yml/badge.svg)](https://github.com/izier/posted/actions/workflows/dart.yml)
Posted is a simple social media app that takes inspiration from Instagram and built with Flutter. It is connected to [JSONPlaceholder](https://jsonplaceholder.typicode.com/) API for its data needs.

## Features

- **Instagram-like home**: Shows lists of post with pictures and individual caption.
- **Explore page**: Shows some of the posts by grid, just like explore page in Instagram.
- **User search**: Search for any users by their username or name.
- **Profile page**: Showcasing me as the developer, some of my links and also my finished projects.

## Dependencies

The Posted app utilizes the following dependencies:
- [http](https://pub.dev/packages/http) (version 0.13.0): A package for making HTTP requests.
- [persistent_bottom_nav_bar](https://pub.dev/packages/persistent_buttom_nav_bar) (version 5.0.2): A package for building a better looking bottom navigation bar.
- [cached_network_image](https://pub.dev/packages/cached_network_image) (version 3.2.3): Caches network images and keeps them in the cache directory.
- [url_launcher](https://pub.dev/packages/url_launcher) (version 6.1.11): Launching any links given with the external browser or any specific apps.

Feel free to explore each dependency by clicking on the respective links above to access their documentation and additional details.

## Installation

To run the Posted app locally, ensure that you have Flutter SDK installed on your system. Then, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/izier/posted.git
```
2. Navigate to the project directory:

```bash
cd posted
```
3. Fetch the required dependencies:

```bash
flutter pub get
```
4. Build and run the app:

```bash
flutter run -d chrome --web-renderer html
```

## Contributing

Contributions to Posted are always welcome! If you have any bug reports, feature requests, or suggestions, please open an issue on the GitHub repository. If you would like to contribute code, you can fork the repository and create a pull request with your changes.

Please ensure that your code adheres to the existing coding style and that you have tested your changes thoroughly before submitting a pull request.
