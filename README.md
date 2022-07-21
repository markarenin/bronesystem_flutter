# bronesystem

Booking system for Tartu Uliopilaskula

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

### Back-end

This app work with private back-end. 

#### LOGIN
  Returns json data about a single user.

* **URL**

  /api/login/

* **Method:**

  `POST`
  
* **Data Params**

   **Required:**
 
   `name=[string] must contains space and lenght > 4`
   `apartment=[integer] >= 200 and <= 418`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{ name : "Michael Bloom", apartment: 200, token: "auth_token" }`
 

#### SERVICES
  Returns json about a collected user data.

* **URL**

  /api/services/

* **Method:**

  `GET`

*  **URL Params**
  None  

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** ```[
    {
        "book_from": "00:00",
        "price": 100,
        "id": 1,
        "booking_days": 2,
        "booking_time": 90,
        "book_to": "23:59",
        "paid": false,
        "disabled": false,
        "name": "Washing machine #1"
    },
    {
        "book_from": "00:00",
        "price": 100,
        "id": 2,
        "booking_days": 2,
        "booking_time": 90,
        "book_to": "23:59",
        "paid": false,
        "disabled": false,
        "name": "Washing machine #2"
    }
]```

#### GET CALENDAR
  Returns json calendar of service and busy times.

* **URL**

  /api/services/:id/

* **Method:**

  `GET`

*  **URL Params**
  `id=[integer] service_id`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** ```{
    "calender": {
        "2022-07-21": [
            "00:00",
            "01:30",
            "03:00",
            "04:30",
            "06:00",
            "07:30",
            "09:00",
            "10:30",
            "12:00",
            "13:30",
            "15:00",
            "16:30",
            "18:00",
            "19:30",
            "21:00",
            "22:30"
        ],
        "2022-07-22": [
            "00:00",
            "01:30",
            "03:00",
            "04:30",
            "06:00",
            "07:30",
            "09:00",
            "10:30",
            "12:00",
            "13:30",
            "15:00",
            "16:30",
            "18:00",
            "19:30",
            "21:00",
            "22:30"
        ]
    },
    "books": []
}```

#### TO BOOK
  Returns json data about booking.

* **URL**

  /api/book/

* **Method:**

  `POST`

*  **URL Params**
  `service_id=[integer] service_id`
  `start_time=[datetime:%Y-%m-%d %H:%m]  Example: 2022-07-20 01:30`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** ```{
    "name": "Adam A",
    "apartment": 201,
    "book": {
        "id": 37,
        "service_id": 1,
        "start_time": "2022-07-20T01:30:00"
    }
}```

* **Error Response:**

  * **Code:** 500 <br />
    **Description:** return 500 if the time already busy and return details about booking
    **Content:** ```{
    "name": "Adam A",
    "apartment": 201,
    "book": {
        "id": 37,
        "service_id": 1,
        "start_time": "2022-07-20T01:30:00"
    }
}```