CREATE TABLE `schema_migrations`(`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `hotels`(
  `id` INTEGER DEFAULT(NULL) NOT NULL PRIMARY KEY AUTOINCREMENT,
  `pub_id` varchar(255) DEFAULT(NULL) NOT NULL,
  `destination_id` INTEGER DEFAULT(NULL) NOT NULL,
  `name` varchar(255) DEFAULT(NULL) NOT NULL,
  `description` varchar(255) DEFAULT(NULL) NOT NULL,
  `location_data` TEXT DEFAULT('{}') NOT NULL,
  `image_data` TEXT DEFAULT(NULL) NULL,
  `created_at` timestamp DEFAULT(datetime(CURRENT_TIMESTAMP, 'localtime')) NULL,
  `updated_at` timestamp DEFAULT(datetime(CURRENT_TIMESTAMP, 'localtime')) NULL,
  `booking_conditions` TEXT DEFAULT('{}') NOT NULL,
  `anemities_data` TEXT DEFAULT('{}') NOT NULL
);
CREATE UNIQUE INDEX `hotels_pub_id_index` ON `hotels`(`pub_id`);
CREATE INDEX `hotels_destination_id_index` ON `hotels`(`destination_id`);
INSERT INTO schema_migrations (filename) VALUES
('20250804191151_create_hotels.rb'),
('20250805152543_update_hotels_details.rb');
