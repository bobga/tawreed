# Tawreed

Tawreed is a web-based platform for managing procurement processes and supplier relationships.

## Description

Tawreed is a comprehensive procurement management system designed to streamline the procurement process, manage supplier relationships, and track purchasing activities. It provides a user-friendly interface for creating, managing, and tracking procurement requests, bids, contracts, and payments. Tawreed helps organizations automate their procurement workflow, improve transparency, and make data-driven decisions.

## Features

- Create and manage procurement requests.
- Invite suppliers to submit bids and proposals.
- Evaluate and compare supplier bids.
- Create and manage contracts with suppliers.
- Track payment status and manage invoices.
- Generate reports for analysis and auditing purposes.

## Technologies Used

- Django
- Django REST Framework
- PostgreSQL
- React.js
- Redux
- Material-UI

## Installation

Clone the repository:

```bash
git clone https://github.com/bobga/tawreed.git
```

Navigate to the project directory:

```bash
cd tawreed
```

Install backend dependencies:

```bash
pip install -r requirements.txt
```

Set up the PostgreSQL database (ensure PostgreSQL is installed and running):

```bash
python manage.py migrate
```

Install frontend dependencies:

```bash
cd frontend
npm install
```

## Usage

Start the Django development server:

```bash
python manage.py runserver
```

Start the React development server (in a separate terminal):

```bash
cd frontend
npm start
```

Access the web application at http://localhost:3000 in your browser.
Use the provided interface to create, manage, and track procurement activities.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
