# PAYBACK Coding Challenge

A new SwiftUI App named **WorldOfPAYBACK** is planned to be released. One of its first features involves displaying a list of transactions, and a corresponding detail screen for each.

## Requirements

* As a user of the App, I want to see a list of (mocked) transactions. Each item in the list displays `bookingDate`, `partnerDisplayName`, `transactionDetail.description`, `value.amount` and `value.currency`. *(see attached JSON File)*
* As a user of the App, I want to have the list of transactions sorted by `bookingDate` from newest (top) to oldest (bottom).
* As a user of the App, I want to get feedback when loading of the transactions is ongoing or an Error occurs. *(Just delay the mocked server response for 1-2 seconds and randomly fail it)*
* As a user of the App, I want to see an error if the device is offline.
* As a user of the App, I want to filter the list of transactions by `category`.
* As a user of the App, I want to see the sum of filtered transactions somewhere on the Transaction-list view. *(Sum of `value.amount`)*
* As a user of the App, I want to select a transaction and navigate to its details. The details-view should just display `partnerDisplayName` and `transactionDetail.description`.
* As a user of the App, I like to see nice UI in general. However, for this coding challenge fancy UI is not required.

## Disclaimer

All rights reserved, 2022 Loyalty Partner GmbH. Any transfer to third parties and/or reproduction is not permitted.
