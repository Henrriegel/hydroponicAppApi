# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
    nickname: 'henrriegel',
    email: 'luis.enrique.gr.legr@outlook.com',
    password: 'henrriegel'
)

Plant.create([
        {
            name: 'Garlic'
        },
        {
            name: 'Onion'
        }
    ]
)

Sensor.create(
    name: '',
    mac_address: '24:D7:EB:58:51:00',
    user_id: '1',
    plant_id: '1'
)

Lecture.create(
    sensor_id: '1',
    roomTemperature: '35',
    temperature1: '15',
    temperature2: '16',
    ph: '7',
    roomHumidity: '89'
)