# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
    [
        {
            nickname: 'henrriegel',
            email: 'luis.enrique.gr.legr@outlook.com',
            password: 'henrriegel'
        },
        {
            nickname: 'testUser',
            email: 'testUser@gmail.com',
            password: 'testUser'
        }
    ]
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
    name: 'Esp32 Test',
    mac_address: 'C8:F0:9E:A6:A5:B8',
    activate: 'false',
    user_id: '1',
    plant_id: '1'
)

Lecture.create(
    [
        {
            sensor_id: '1',
            roomTemperature: '35',
            temperature1: '15',
            temperature2: '16',
            ph: '7',
            roomHumidity: '89'
        },
        {
            sensor_id: '1',
            roomTemperature: '23',
            temperature1: '18',
            temperature2: '17',
            ph: '6.5',
            roomHumidity: '90'
        }
    ]
)