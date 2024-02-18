#  🛌 Flutter Furniture App (Timberr) 🪑

Timberr is a robust and feature-rich furniture application clone meticulously crafted using Flutter, Supabase, and Getx State Management. This app seamlessly integrates a sophisticated UI design to provide users with an immersive and intuitive furniture shopping experience.

This app is based on this [UI Design](https://www.figma.com/file/dTdGEtZoQd2uRZc8qS5xjr/Timberr?node-id=0%3A1).

## ✨ Key Features:

- 🔐 Authentication: Timberr ensures a secure and personalized experience with a robust authentication system, allowing users to create accounts, log in securely, and manage their profiles effortlessly.

- 🛒 Cart: The app features a fully functional shopping cart, enabling users to add, remove, and manage items with ease. The cart ensures a smooth and efficient checkout process for a seamless shopping journey.

- 💖 Favorites: Timberr incorporates a favorites section, allowing users to curate a personalized list of preferred items. This feature enhances user engagement by providing a quick and convenient way to revisit and purchase favored products.

- 🗺️ Address: Users can effortlessly manage their delivery addresses, ensuring a hassle-free and customized shopping experience. The address feature enhances convenience by enabling users to save and update their preferred delivery locations.

- 🔍 Search and Filtering: Timberr integrates a powerful search functionality and advanced filtering options, facilitating users in discovering desired furniture items efficiently.

- 🌈 Select Color: Users can customize their furniture selection by choosing from a variety of colors, adding a touch of personalization to their shopping experience.

- 💳 Payment Methods: The app supports multiple payment methods, ensuring a secure and versatile checkout process for users. This feature includes integration with the Razorpay payment gateway for a seamless and reliable transaction experience.

- 👤 User Profile Management: Timberr empowers users to personalize their profiles by enabling them to change profile pictures, update names, passwords, and other user-related settings, enhancing the overall user experience.

- 💫 Smooth Animations: The app incorporates smooth and visually appealing animations, enhancing the overall user interface and providing a delightful interaction experience.

- 🚧 Reviews, Orders, and Notifications: While currently implemented as UI elements, Timberr sets the foundation for future functionality, allowing users to access and view product reviews, order history, and notifications – enhancing user engagement and information accessibility.

## 💻 Installation links

[![Download Android Apk](https://img.shields.io/badge/Download-Android%20Apk-green)](https://github.com/adeeteya/FlutterFurnitureApp/releases/download/2.0.0/timberr-2.0.0.apk)

[![Download iOS ipa](https://img.shields.io/badge/Download-iOS%20App-black)](https://github.com/adeeteya/FlutterFurnitureApp/releases/download/1.0.0/timberr-1.0.0.ipa)

## 📸 Screen Recordings

<details>
<summary><b>Authentication</b></summary>
<img alt="Register" loading="lazy" src="images/register.gif" height="587px" width="256px"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Login" loading="lazy" src="images/login.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Cart</b></summary>
<img alt="Add to Cart" loading="lazy" src="images/add_to_cart.gif" height="587px" width="256px"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Cart Updation" loading="lazy" src="images/cart_updation.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Favorites</b></summary>
<img alt="Favorites" loading="lazy" src="images/favorites.gif" height="587px" width="256px"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Favorites Search" loading="lazy" src="images/favorites_search.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Address</b></summary>
<img alt="Address" loading="lazy" src="images/address.gif" height="587px" width="256px"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Delete Address" loading="lazy" src="images/delete_address.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Searching and Filtering</b></summary>
<img alt="Product Search" loading="lazy" src="images/product_search.gif" height="587px" width="256px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Filter" loading="lazy" src="images/filter.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Payment</b></summary>
<img alt="Payment Method" loading="lazy" src="images/payment_method.gif" height="587px" width="256px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Payment" loading="lazy" src="images/payment.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Account Settings and Notifications</b></summary>
<img alt="Change Account" loading="lazy" src="images/change_account_settings.gif" height="587px" width="256px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Notifications" loading="lazy" src="images/notification.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Reviews</b></summary>
<img alt="My Reviews" loading="lazy" src="images/my_reviews.gif" height="587px" width="256px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Product Reviews" loading="lazy" src="images/product_review.gif" height="587px" width="256px"/>
</details><br>

<details>
<summary><b>Orders and Sign-out</b></summary>
<img alt="Orders" loading="lazy" src="images/orders.gif" height="587px" width="256px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img alt="Sign out" loading="lazy" src="images/sign_out.gif" height="587px" width="256px"/>
</details><br>

## 🗃️ Database Schema

<img src="images/database.png">

## 🔌 Plugins

| Name                                                                      | Usage                                            |
|---------------------------------------------------------------------------|--------------------------------------------------|
| [**get**](https://pub.dev/packages/get)                                   | Dependency injection, State and Route management |
| [**supabase_flutter**](https://pub.dev/packages/supabase_flutter)         | Authentication, Database and Storage             |
| [**cached_network_image**](https://pub.dev/packages/cached_network_image) | Caching Product and user images                  |
| [**lottie**](https://pub.dev/packages/lottie)                             | Loading Animations                               |
| [**url_launcher**](https://pub.dev/packages/url_launcher)                 | To open FAQ in a browser                         |
| [**image_picker**](https://pub.dev/packages/image_picker)                 | To select user profile picture from their device |
| [**razorpay_flutter**](https://pub.dev/packages/razorpay_flutter)         | Payment Gateway through Razorpay                 |
| [**flutter_lints**](https://pub.dev/packages/flutter_lints)               | For linting                                      |

## 📃 Feature Todo List

- [x] Authentication
- [x] Cart
- [x] Favorites
- [x] Address
- [x] Search
- [x] Filtering
- [x] Select Color
- [x] Change Quantity
- [x] Payment Methods
- [x] Razorpay Payment Gateway
- [x] Change User Profile Picture
- [x] Change Name/Password and other User Related Settings
- [x] Smooth Animations
- [x] Loading Screens
- [ ] Reviews (Only UI implemented)
- [ ] Orders (Only UI implemented)
- [ ] Notifications (Only UI implemented)
- [ ] Dark Mode
- [ ] Responsive Design (Only Mobile version implemented)

## 🤓 Author

**[Aditya R](https://github.com/adeeteya)**

## 🔖 LICENCE
Copyright (c) 2022 Aditya R
[MIT LICENCE](https://github.com/adeeteya/FlutterFurnitureApp/blob/master/LICENSE)