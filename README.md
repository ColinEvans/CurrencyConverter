# CurrencyConverter
A currency converting application using the open exchange rates API

Functional Requirements:
- The required data must be fetched from the open exchange rates service using the free account.
- The required data must be persisted locally to permit the application to be used
offline after data has been fetched.
- In order to limit bandwidth usage, the required data can be refreshed from the API no more frequently than once every 30 minutes.
- The user must be able to select a currency from a list of currencies provided by open exchange rates.
- The user must be able to enter the desired amount for the selected currency.
- The user must then be shown a list showing the desired amount in the selected currency converted into amounts in each currency provided by open exchange rates.
  - If exchange rates for the selected currency are not available via open exchange rates, perform the conversions on the app side.
  - When converting, floating point errors are acceptable.
