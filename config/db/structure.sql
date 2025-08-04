CREATE TABLE `schema_migrations`(`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `hotels`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `pub_id` varchar(255) NOT NULL,
  `destination_id` integer NOT NULL,
  `name` varchar(255) NOT NULL,
  `loc_lat` double precision NOT NULL,
  `loc_long` double precision NOT NULL,
  `loc_location` varchar(255) NOT NULL,
  `loc_city` varchar(255) NOT NULL,
  `loc_country` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `location_data` text NOT NULL,
  `image_data` text,
  `created_at` timestamp DEFAULT(datetime(CURRENT_TIMESTAMP, 'localtime')),
  `updated_at` timestamp DEFAULT(datetime(CURRENT_TIMESTAMP, 'localtime'))
);
CREATE UNIQUE INDEX `hotels_pub_id_index` ON `hotels`(`pub_id`);
CREATE INDEX `hotels_destination_id_index` ON `hotels`(`destination_id`);
INSERT INTO schema_migrations (filename) VALUES
('20250804191151_create_hotels.rb');
