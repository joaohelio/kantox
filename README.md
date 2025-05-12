# Kantox

A checkout system for a small chain of supermarkets

## Features

- Add products to the cart
- Apply special pricing rules:
  - Buy-one-get-one-free for Green Tea
  - Bulk discount for Strawberries (3+ units: £4.50 each)
  - Two-thirds price for Coffee when buying 3+ units

## Setup

You can run this project using Docker.

### Docker Setup

#### Prerequisites

- Docker
- Docker Compose

#### Installation

1. Clone the repository
```bash
git clone https://github.com/joaohelio/kantox.git
cd kantox
```

2. Set up environment variables:

Create the following file and populate it with the respective environment variables:
**.env**
```bash
SECRET_KEY_BASE=SECRET
MIX_ENV=dev
```

3. Start the container:
```bash
docker compose up --build
```

4. Visit [`localhost:4000/checkout`](http://localhost:4000/checkout) in your browser

## Running Tests

You can run tests inside the container:
```bash
alias dc-test="docker compose -f docker-compose.yml"

dc-test run -e MIX_ENV=test kantox mix test
```

## Project Structure

- `lib/kantox/shopping_cart.ex` - Shopping cart logic
- `lib/kantox/pricing_rules.ex` - Pricing rules implementation
- `lib/kantox/product.ex` - Product schema
- `lib/kantox_web/live/` - LiveView components for the UI

![image](https://github.com/user-attachments/assets/d5f5ba2e-6795-4bdb-9852-b76bf16c919f)
