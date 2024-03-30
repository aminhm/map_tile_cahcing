# Sparkco - Getting Started Guide for Developers

Welcome to the Sparkco repository! We're excited to have you on board as a new developer. This guide will help you set up your development environment and contribute to the project. If you have any questions or face issues, feel free to reach out to the team.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setting up Flutter SDK](#setting-up-flutter-sdk)
3. [Adding .env File](#adding-env-file)
4. [Configuring Your IDE](#configuring-your-ide)
5. [Creating Feature Branches](#creating-feature-branches)
6. [Making Pull Requests](#making-pull-requests)
7. [ Coding Conventions with Flutter Lints](#coding-conventions-with-flutter-lints)

## Prerequisites

Before you start, make sure you have the following installed on your machine:

1. [Flutter SDK](https://flutter.dev/docs/get-started/install)
2. [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
3. [Your preferred IDE with Flutter support (e.g., Android Studio, VSCode)](https://flutter.dev/docs/get-started/editor)

## Setting up Flutter SDK

If you haven't installed the Flutter SDK yet, follow these steps:

1. Visit the [Flutter installation page](https://flutter.dev/docs/get-started/install) and choose your operating system.
2. Download the Flutter SDK and extract it to a location of your choice.
3. Add the Flutter `bin` directory to your system's `PATH` environment variable to access Flutter CLI globally.

To verify your installation, open a terminal or command prompt and run:

```bash
flutter doctor
```

This command will check if all the required dependencies are installed correctly.

## Adding .env File

Our project uses environment variables, and you need to set up your local `.env` file. Here's how:

1. Create a copy of the `.env.example` file located in the root of the project.
2. Rename the copied file to `.env`.
3. Fill in the necessary environment variables, which could include API keys, database URLs, etc. (request these from Tuomas).

**Important**: Never commit your `.env` file to version control. We have already added it to `.gitignore` to avoid accidental commits.

## Configuring Your IDE

Depending on your preferred IDE, follow the appropriate instructions to set up Flutter support:

### Android Studio

1. Install the Flutter and Dart plugins via `Preferences > Plugins > Browse Repositories > Flutter/Dart`.
2. Restart Android Studio to apply the changes.

### VSCode

1. Install the Flutter and Dart extensions from the VSCode Marketplace.
2. Restart VSCode to apply the changes.
3. (Optional) Some other helpful extensions for VSCode: Flutter Widget Snippets, bloc

## Creating Feature Branches

When you work on a new feature or fix an issue, always create a new branch:

1. Update your local main branch with the latest changes from the upstream repository:
   ```bash
   git checkout main
   git pull origin main
   ```

2. Create a new feature branch off the main branch, with a descriptive name:
   ```bash
   git checkout -b feature/my-new-feature
   ```

3. Implement your changes, commit them, and push the branch to the remote repository:
   ```bash
   git add .
   git commit -m "Implement my new feature"
   git push origin feature/my-new-feature
   ```

## Making Pull Requests

Once you have implemented your changes and are ready to contribute back to the project, create a pull request:

1. Go to the project's GitHub repository.
2. Switch to your feature branch using the branch selector drop-down.
3. Click on the "New Pull Request" button.
4. Add a descriptive title and detailed description of your changes.
5. If the pull request resolves an issue, mention it using the keyword "Fixes #issue_number."
6. Request a review from one or more team members.
7. Once the pull request is approved, it will be merged into the staging branch.

Thank you for joining our project! We're looking forward to your valuable contributions. If you have any questions or need further assistance, don't hesitate to ask in the GitHub discussions or our team chat.

## Coding Conventions with Flutter Lints

In this project, we follow the coding conventions provided by the `flutter_lints` package. These conventions are based on the Effective Dart guidelines with additional Flutter-specific rules. Adhering to these conventions will help ensure that our Flutter code is clean, readable, and consistent across the codebase.

### Linting

We use the `flutter_lints` package to enforce lint rules for our Flutter code. The linter will analyze your code for potential issues and enforce best practices specific to Flutter development.

### Formatting

For code formatting, we recommend using `dart format` and `dart fix --dry-run` to ensure consistency and proper formatting across the codebase. `dart format` automatically formats your code according to the Dart style guide, while `dart fix --dry-run` shows the potential fixes without actually modifying the files.

To format your code using `dart format`, run the following command:

```bash
dart format
```

To see potential fixes for lint issues without applying them, run:

```bash
dart fix --dry-run
```

### Tips for Flutter Coding with flutter_lints

1. **Widget Naming**: When creating custom widgets, use descriptive and meaningful names that reflect their purpose and behavior.

2. **Avoid Deprecated APIs**: Regularly check for deprecated APIs and update your code to use their latest replacements.

3. **Null Safety**: With Flutter supporting null safety, embrace non-nullable types and handle null cases appropriately.

4. **Avoid `setState` in Build Methods**: Avoid calling `setState` within a widget's build method, as it may lead to performance issues and multiple rebuilds.

5. **Use `const` Constructors**: For widgets with constant properties, use `const` constructors to enable better performance optimizations.

6. **Separation of Concerns**: Follow the separation of concerns principle, keeping UI, business logic, and data management in their respective layers.

7. **Widget Composition**: Prefer composing widgets over long and complex widget trees. This enhances code maintainability and reusability.

### Commenting and Documenting Code

To ensure code maintainability and ease of understanding, we strongly encourage the practice of commenting and documenting your code following the Effective Dart guidelines:

1. **Doc Comments**: Add doc comments to public APIs, classes, methods, and functions. Describe their purpose, input parameters, return values, and any relevant details.

2. **Comments for Complex Logic**: Use comments to explain intricate or non-obvious logic to aid developers who may need to work with the code later.

3. **Keep Comments Updated**: Regularly review and update comments when you make changes to the code to keep them accurate and helpful.

4. **Code Documentation**: In addition to doc comments, consider creating separate documentation for more extensive code explanations or architecture overviews.

### Helpful Resources

- [flutter_lints Package](https://pub.dev/packages/flutter_lints): More information about the flutter_lints package and the lint rules it enforces.
- [Effective Dart](https://dart.dev/guides/language/effective-dart): Official Dart guidelines, including information on commenting and documentation best practices.

By adhering to the Flutter-specific lint rules provided by `flutter_lints`, using `dart format`, and reviewing potential fixes with `dart fix --dry-run`, while maintaining proper comments and documentation, we ensure that our Flutter codebase remains clean, well-documented, and aligned with industry best practices.

Happy coding and happy Fluttering! 🚀

## Adding Support for More Countries / Updating Existing Places

To expand the support for additional countries or update existing places in the app, follow these steps:

1. **Get the OSM File**: Obtain the OpenStreetMap (OSM) file for the region you want to add or update. You can download OSM data for various regions from sources like https://download.geofabrik.de.

2. **Extract Point of Interest Information**: Use Osmosis to scrape out the Point of Interest (POI) information from the OSM data. For instance, if you want to collect data for bars, pubs, biergartens, cafes, restaurants, colleges, universities and nightclubs in Finland, use the following command:
   ```bash
   osmosis --read-pbf finland-latest.osm.pbf \
        --tf accept-nodes \
        amenity=bar,pub,biergarten,cafe,restaurant,college,university,nightclub \
        --tf reject-ways --tf reject-relations \
        --write-xml Finland.nodes.osm
   ```
   You can find a list of supported Points of Interest at https://wiki.openstreetmap.org/wiki/Map_features.

3. **Remove Unnecessary Data**: Use `osmconvert` to filter out unnecessary data from the extracted OSM file:
   ```bash
   osmconvert Finland.nodes.osm --drop-ways --drop-author --drop-relations --drop-versions -o=Finland.poi.osm
   ```

4. **Convert POI Data to GeoJSON**: Utilize `ogr2ogr` to convert the filtered POI data to GeoJSON format:
   ```bash
   ogr2ogr -f GeoJSON Finland.poi.json Finland.poi.osm points
   ```

5. **Upload GeoJSON to Admin Panel**: Upload the generated GeoJSON data to the admin panel. The data will undergo further processing before being populated into Firestore with the Points of Interest.

Note: You could add the whole planet.osm at once but current provision is 1 vCPU with 1GB RAM and 600 second timeout so it is unlikely to succeed.
