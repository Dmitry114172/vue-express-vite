-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 11 2025 г., 16:38
-- Версия сервера: 8.0.39
-- Версия PHP: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `db2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cart`
--

CREATE TABLE `cart` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Смартфоны'),
(2, 'Наушники'),
(3, 'Ноутбуки');

-- --------------------------------------------------------

--
-- Структура таблицы `images`
--

CREATE TABLE `images` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `images`
--

INSERT INTO `images` (`id`, `product_id`, `image_url`) VALUES
(1, 1, 'honor7c.webp'),
(2, 1, 'honor7cBlack.webp'),
(3, 1, 'honor7cWhite.webp'),
(16, 2, 'iphone16pro.webp'),
(17, 2, 'iphone16protitan.webp'),
(22, 3, 'redmi-a3-green.webp'),
(23, 3, 'redmi-a3-green2.webp');

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `vendor` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `short_description` text COLLATE utf8mb4_general_ci,
  `description` text COLLATE utf8mb4_general_ci,
  `technical_specifications` text COLLATE utf8mb4_general_ci,
  `recommended_section1` int DEFAULT NULL,
  `recommended_section2` int DEFAULT NULL,
  `recommended_section3` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `vendor`, `title`, `short_description`, `description`, `technical_specifications`, `recommended_section1`, `recommended_section2`, `recommended_section3`, `price`, `category_id`) VALUES
(1, 'HONOR', 'Смартфон HONOR X7C 8+128Gb зеленый (5109BRSJ)', 'HONOR X7C хороший телефон', 'HONOR X7C хороший телефон', 'Бренд\r\nHONOR\r\nЦвет товара\r\nforest green\r\nВерсия\r\nРостест (EAC)\r\nВерсия ОС на начало продаж\r\nAndroid 14\r\nТип корпуса\r\nклассический\r\nМатериал корпуса\r\nпластик\r\nСтепень защиты\r\nIP64\r\nКоличество SIM-карт\r\n2\r\nВес\r\n201 г\r\n\r\nЭкран\r\nДисплей\r\n6.77\", IPS\r\n\r\nМультимедийные возможности\r\nФункции камеры\r\nДвойная камера\r\nКоличество основных (тыловых) камер\r\n2\r\nРазрешение фронтальной камеры\r\n8 МП\r\n\r\nСвязь\r\nСтандарт связи\r\n2G, 3G, 4G LTE\r\nБеспроводные интерфейсы\r\nBluetooth, NFC, Wi-Fi, 3.5 мм, USB Type-C\r\nСтандарт Wi-Fi\r\n802.11ac\r\nСтандарт Bluetooth\r\n5.0\r\nГеопозиционирование\r\nA-GPS, BeiDou, GPS, Galileo, ГЛОНАСС\r\n\r\nПамять и процессор\r\nХарактеристики процессора\r\n2.8\r\nВстроенная память\r\n128 ГБ\r\nОперативная память\r\n8 ГБ\r\nСлот для карт памяти\r\nесть\r\n\r\nПитание\r\nФункции зарядки\r\nбыстрая зарядка\r\n\r\nДругие функции\r\nОсобенности\r\nДатчик распознавания лица, Сканер отпечатка пальца\r\nАутентификация\r\nразблокировка по лицу, Сканер отпечатка\r\n\r\nДополнительная информация\r\nЗаводская комплектация\r\nСмартфон, защитная пленка (наклеена на экран), кабель USB Type-C, зарядное устройство, документация, скрепка для извлечения слота SIM-карты / карты памяти\r\nБренд графического процессора\r\nARM\r\nБренд процессора\r\nQualcomm\r\nВосстановленный\r\nfalse\r\nГод анонсирования\r\n2024\r\nПоддержка eSim\r\nSIM (без eSIM)\r\nРазмеры, мм\r\n166.9*76.8*8.24\r\nТип карты памяти\r\nmicroSDXC\r\nФорм-фактор SIM\r\nNano-SIM\r\nЧисло ядер процессора\r\n8\r\n\r\nГабариты и вес с учетом упаковки\r\nГабариты транспортной упаковки\r\n9х17.50х6 см\r\nВес в транспортной упаковке\r\n0.473 кг', NULL, NULL, NULL, 9999.99, 1),
(2, 'iPhone', 'Смартфон Apple iPhone 16 Pro Max 1Tb, A3295, титан', 'Apple iPhone 16 Pro Max — новинка 2024 года с 1 ТБ внутренней памяти', 'Apple iPhone 16 Pro Max — новинка 2024 года с 1 ТБ внутренней памяти, что позволяет хранить на устройстве еще больше личной информации, приложений и файлов, фото и видео в высоком разрешении. Встроенный энергоемкий аккумулятор позволяет использовать смартфон в режиме прослушивания музыки до 105 часов. Корпус защищен по классу IP68, устойчив к ударам, не пропускает влагу.\r\n\r\nПреимущества Apple iPhone 16 Pro Max:\r\n\r\nРазблокировка по лицу.\r\nВозможность экстренного вызова SOS.\r\nПоддержка аксессуаров и устройств беспроводной зарядки MagSafe.\r\nТехнология Qi для беспроводной зарядки.\r\nЗащитное стекло Ceramic Shield2.5D.\r\nКамеры с поддержкой распознавания лиц.\r\nБольшой и яркий экран\r\n\r\nApple iPhone 16 Pro Max получил экран диагональю 6.9 дюйма с разрешением 2868х1320 точек. Матрица OLED Super Retina XDR с яркостью 2000 кд/м2 передает черные цвета максимально глубоко, обеспечивает высокую контрастность при воспроизведении видео и игр.\r\n\r\nЧастота обновления 120 Гц делает изображение более плавным и увеличивает отклик пикселей. Это значительно улучшает качество восприятия игр и видео.\r\n\r\nКачественная фото и видео съемка\r\n\r\nМодель получила 3 основных (тыловых) камеры с оптикой Sony. С помощью широкоугольного объектива 48 Мп получаются снимки в высоком разрешении, а подсветка позволяет делать фото в сумерках и помещениях с недостаточным освещением.\r\n\r\nСверхширокоугольный объектив 48 Мп позволяет захватывать максимум объектов в кадр для получения панорамных снимков. Предусмотрен 25-кратный цифровой и 10-кратный оптический зум для приближения без потери качества. Видеосъемка может вестись с разрешением 3840х2160 и частотой кадров 240 кадров/сек.', 'Общие характеристики\r\nТип\r\nСмартфон\r\nБренд\r\nAPPLE\r\nСерия\r\niPhone 16 Pro Max\r\nМодель\r\nA3295\r\nГод релиза\r\n2024\r\nАккумулятор\r\nLi-Ion, несъемный\r\nЛокализация\r\nЯпония\r\nПоддержкаAI\r\nда\r\nТехнология AI\r\nApple Intelligence\r\nСотовая связь\r\nКоличество физических SIM-карт\r\n1, nano SIM\r\nПоддержка eSIM\r\nда\r\nСтандарт связи\r\n2G/3G/4G (LTE)/5G\r\nТип лоткаSIM\r\nстандартный (только SIM)\r\nКоличество поддерживаемых eSIM\r\n1\r\nДополнительные виды связи\r\nVoLte\r\nКоммуникация и датчики\r\nАутентификация\r\nразблокировка по лицу\r\nСтандартWiFi\r\n802.11 a/b/g/n/ac/ax/be\r\nСтандарт Bluetooth\r\nv5.3\r\nБеспроводныеинтерфейсы\r\nNFC\r\nСистемы навигации\r\nGPS / ГЛОНАСС / BeiDou / Galileo / QZSS\r\nДатчики\r\nLiDAR, датчик освещенности, датчик приближения, акселерометр (G-sensor), гироскоп, барометр\r\nЭкран\r\nТехнология экрана\r\nOLED Super Retina XDR\r\nЭкран\r\n6.9\" (2868x1320)\r\nСоотношение сторон экрана\r\n19.5:9\r\nЧисло пикселей на дюйм\r\n460\r\nЯркость\r\n2000 кд/м2\r\nПоддержка HDR\r\nесть, HDR10\r\nОсобенности экрана\r\nMultitouch\r\nЧастота обновления\r\n120 Гц\r\nПамять и процессор\r\nОперационная система\r\niOS\r\nВерсия ОС на момент выходамодели\r\niOS 18\r\nПроцессор\r\nApple A18 Pro\r\nКоличество ядерпроцессора\r\n6\r\nТехпроцесс\r\n3 нм\r\nГрафический ускоритель\r\nApple\r\nОбъем встроеннойпамяти\r\n1024 ГБ\r\nОсновная (тыловая) камера\r\nКоличество основных (тыловых) камер\r\n3\r\nОптика и сенсор основной камеры\r\nSony\r\nОсновнойобъектив\r\nширокоугольная 48 Мп / размер матрицы 1/1,28 / диафрагма F/1.78 / фокусное расстояние 24 мм / размер пикселя 1.22 мкм / количество линз камеры 7 / OIS (оптическая стабилизация)\r\nСверхширокоугольный объектив\r\n48 Мп / диафрагма F/2.2 / фокусное расстояние 13 мм / угол обзора 120\r\nТелеобъектив\r\n12 Мп / диафрагма F/2.8 / фокусное расстояние 77 мм / OIS (оптическая стабилизация)\r\nОсобенности камер\r\nоптический 2x (на уменьшение), оптический 5x (на увеличение), диапазон оптического зума 10x, цифровой 25x\r\nТипвспышки\r\nсветодиодная\r\nОсобенности фотосъемки\r\nВспышка True Tone, функция Smart HDR 5, привязка фотографий к месту съемки, портретное освещение, коррекция искажений объектив, технология Deep Fusion, форматы изображений: HEIF, JPEG, and DNG, широкий цветовой диапазон для фотографий и Live Photos, технология Photonic Engine, формат Apple ProRAW\r\nАвтофокусировкакамеры\r\nесть\r\nЗум\r\n25-кратный цифровой зум, 10-кратный оптический зум\r\nРежимы съемки основной камеры\r\nРежим «Портрет» с улучшенным эффектом боке и функцией «Глубина», ночной режим, панорамная съемка, серийная съемка фото и видео, портреты в ночном режиме с помощью LiDAR Scanner, фотографические стили, макросъемка, фотографические стили, передовая система устранения эффекта красных глаз\r\nРаспознание лиц\r\nесть\r\nВидеосъемка (основная камера)\r\nРазрешение видеосъемки\r\n1920x1080, 3840x2160\r\nМакс. частота кадров видео\r\n240 кад/сек\r\nВидеосъемка 1080p HD\r\n120, 240, 25, 30, 60 кад/сек\r\nВидеосъемка Ultra HD 4K\r\n120, 24, 25, 30, 60 кад/сек\r\nРежимы видеосъемки\r\n4K с частотой 120 кадров/?с, функция QuickTake, форматы видео: HEVC, H.264 и ProRes, режим \"Киноэффект\" для съёмки видео до 4K HDR с частотой 30 кадров/с\r\nОсобенности видеосъемки\r\nРазрешение замедленного видео: HD-видео 1080p c частотой 120 кадров/с или 240 кадров/с, 4K Dolby Vision до 120 кадров/с\r\nФронтальная камера\r\nТип фронтальной камеры\r\nстандартная\r\nРазрешение фронтальной камеры\r\n12\r\nДиафрагма, фронтальная камера\r\nF/1.9\r\nАвтофокусировка фронтальной камеры\r\nесть\r\nРежимы съемки фронтальной камеры\r\nрежим \"Портрет\" с улучшенным эффектом боке и функцией \"Глубина\", портретное освещение, анимированные смайлики Animoji и Memoji, ночной режим, фотографические стили, широкий цветовой диапазон для фотографий и Live Photos, коррекция искажений объектива\r\nМультимедиа\r\nСтереодинамики\r\nесть\r\nПоддерживаемыеаудиоформаты\r\nAAC, APAC, MP3, Apple Lossless, FLAC, Dolby Digital, Dolby Digital Plus, и Dolby Atmos\r\nПоддерживаемыевидеоформаты\r\nHEVC, H.264, AV1, и ProRes\r\nРазъем для подключениянаушников\r\nUSB Type-C\r\nОсобенности\r\nОсобенности\r\nСапфировое стекло объектива, кнопка Action, Dynamic Island, Экстренный SOS через спутник, Поддержка аксессуаров и устройств беспроводной зарядки MagSafe, USB 3 (до 10 Гбит/с)\r\nКомплектация\r\niPhone, Кабель USB-C(1 м), Документация\r\nПитание\r\nРазъем для зарядного устройства\r\nUSB Type-C\r\nВремя работы при прослушиваниимузыки\r\n105 ч\r\nВремя работы при воспроизведениивидео\r\n33 ч\r\nПоддержка быстрой зарядки\r\nесть\r\nПоддержка беспроводной зарядки\r\nесть, технология Qi\r\nКорпус и защита\r\nТип корпуса\r\nмоноблок\r\nМатериал экрана\r\nстекло Ceramic Shield, 2.5D, устойчивое к царапинам\r\nОсобенности защиты\r\nзащита от пыли и влаги, можно погружать в воду макс: 6 м, 30 мин\r\nМатериалкорпуса\r\nтитан\r\nЦвет\r\nтитан\r\nСтепень защиты\r\nIP68\r\nРазмеры (ШхВхТ)\r\n77.6 х 163 х 8.25 мм\r\nВес товара\r\n227 грамм\r\nУпаковка\r\nГабариты упаковки (ед) ДхШхВ\r\n0.18x0.095x0.03 м\r\nВес упаковки (ед)\r\n0.49 кг\r\nДополнительные характеристики\r\nГарантия\r\n12 мес.\r\nПроизводитель оставляет за собой право изменять характеристики товара, его внешний вид и комплектность без предварительного уведомления продавца.\r\n\r\nПредложение по продаже товара действительно в течение срока наличия этого товара на складе.', NULL, NULL, NULL, 120000.99, 2),
(3, 'Xiaomi', '6.71\" Смартфон Xiaomi Redmi A3x 64 ГБ зеленый', 'Смартфон Xiaomi Redmi A3x в зеленом цвете имеет 6.71-дюймовый', 'Смартфон Xiaomi Redmi A3x в зеленом цвете имеет 6.71-дюймовый IPS-дисплей с разрешением 1650x720. Восьмиядерный процессор с тактовой частотой 1.8 ГГц в сочетании с 3 ГБ оперативной памяти справляются при работе с играми и видеоредакторами. Основная камера с разрешением 8 Мп и дополнительная 0.08 Мп позволяют создавать снимки в формате Full HD. Аккумулятор на 5000 мА/ч позволяет слушать до 135.3 часов музыки без подзарядки. Функция распознавания лица и сканер отпечатков пальцев позволяют мгновенно разблокировать телефон. Поддержка OTG позволяет подключать флешки к Xiaomi Redmi A3x.', 'Заводские данные\r\nГарантия продавца / производителя\r\n12 мес.\r\nСтрана-производитель \r\nКитай\r\nОбщие параметры\r\nТип\r\nсмартфон\r\nМодель\r\n Xiaomi Redmi A3x\r\nКод производителя\r\n[MZB0H3YRU]\r\nГод релиза\r\n 2024\r\nВнешний вид\r\nЦвет задней панели\r\n зеленый\r\nЦвет граней\r\n зеленый\r\nЦвет, заявленный производителем\r\n Aurora Green\r\nМобильная связь\r\nДиапазоны частот 2G\r\n GSM 850 (B5), GSM 900 (B8), GSM 1800 (B3), GSM 1900 (B2)\r\nДиапазоны частот 3G\r\n UMTS 850 (B5), UMTS 900 (B8), UMTS 2100 (B1)\r\nПоддержка сетей 4G (LTE) \r\n есть\r\nДиапазоны частот 4G (LTE)\r\n FDD-LTE 700 (B28), FDD-LTE 800 (B20), FDD-LTE 850 (B5), FDD-LTE 900 (B8), FDD-LTE 1700 (B4), ещё\r\nПоддержка сетей 5G \r\n нет\r\nФормат SIM-карт\r\n Nano-SIM\r\nКоличество физических SIM-карт\r\n 2\r\nКоличество eSIM\r\n 0\r\nРежим работы нескольких SIM-карт \r\n режим ожидания\r\nЭкран\r\nДиагональ экрана (дюйм) \r\n 6.71\"\r\nРазрешение экрана \r\n 1650x720\r\nТехнология изготовления матрицы\r\n IPS\r\nТип матрицы (подробно) \r\nIPS\r\nЯркость\r\n 500 Кд/м²\r\nЧастота обновления экрана \r\n 90 Гц\r\nПлотность пикселей \r\n 268 ppi\r\nСоотношение сторон \r\n 20:9\r\nКонструкция и защита\r\nТип корпуса\r\n классический\r\nМатериал корпуса\r\nпластик, стекло\r\nТип выреза на экране\r\nкаплевидный/V-образный\r\nОперационная система и процессор\r\nОперационная система\r\nAndroid\r\nВерсия ОС\r\n Android 14 Go\r\nПоддержка Google Mobile Services \r\n есть\r\nМодель процессора\r\n Unisoc Tiger T603\r\nКоличество ядер \r\n 8\r\nМаксимальная частота процессора \r\n 1.8 ГГц\r\nКонфигурация процессора \r\n 4x Cortex-A55 1.2 ГГц, 4x Cortex-A55 1.8 ГГц\r\nТехпроцесс \r\n 12 нм\r\nГрафический ускоритель \r\n Mali-G57 MP1\r\nПамять\r\nТип оперативной памяти\r\nLPDDR4X\r\nОбъем оперативной памяти \r\n 3 ГБ\r\nВиртуальное расширение ОЗУ\r\n0 ГБ\r\nТип встроенной памяти\r\neMMC 5.1\r\nОбъем встроенной памяти \r\n 64 ГБ\r\nСлот для карты памяти\r\nесть (отдельный слот)\r\nТипы поддерживаемых карт памяти\r\nmicroSD, microSDHC, microSDXC\r\nМаксимальный объем карты памяти\r\n 1024 ГБ\r\nОсновная (тыловая) камера\r\nКоличество основных (тыловых) камер \r\n 2\r\nКоличество мегапикселей основной камеры \r\n8+0.08 Мп\r\nАпертура основной камеры \r\n 2\r\nАвтофокусировка основной камеры \r\n есть\r\nТип вспышки\r\nодинарная светодиодная\r\nОптическая стабилизация \r\n нет\r\nОсобенности и технологии тыловой оптики\r\n 4-элементная линза\r\nРежимы и функции фотосъемки\r\n портретная съемка, режим HDR\r\nВидеосъемка (основная камера)\r\nФормат видеосъемки\r\n Full HD, HD\r\nРазрешение видео и частота кадров \r\n 1280x720 (30 кадр./сек.), 1920x1080 (30 кадр./сек.)\r\nОсобенности и функции видеосъемки\r\nрежим «Таймлапс»\r\nФронтальная камера\r\nДвойная фронтальная камера \r\n нет\r\nКоличество мегапикселей фронтальной камеры \r\n 5 Мп\r\nАпертура фронтальной камеры \r\n 2.2\r\nАвтофокусировка \r\n нет\r\nВстроенная вспышка \r\n нет\r\nРазрешение видеосъемки \r\n 1280x720 (30 кадр./сек.), 1920x1080 (30 кадр./сек.)\r\nРежимы и функции съемки\r\n портретная съемка, режим HDR, режим «Таймлапс»\r\nАудио\r\nСтереодинамики \r\n нет\r\nПоддержка кодеков Bluetooth\r\n AAC, SBC\r\nFM радио \r\n есть\r\nКоммуникации\r\nВерсия Bluetooth \r\n5.0\r\nСтандарт Wi-Fi \r\n4 (802.11n)\r\nNFC \r\n нет\r\nСистемы навигации\r\n A-GPS, GPS, Galileo, ГЛОНАСС\r\nИК-порт \r\n нет\r\nРазъемы и датчики\r\nИнтерфейс для зарядки \r\nUSB Type-C\r\nРазъем для наушников \r\n jack 3.5 мм\r\nПоддержка OTG \r\n есть\r\nДатчики\r\n акселерометр, датчик освещенности, датчик приближения, компас\r\nПитание\r\nЕмкость аккумулятора \r\n 5000 мА*ч\r\nНапряжение питания ЗУ\r\n 100-240 В/50-60 Гц\r\nВыходная мощность ЗУ\r\n 10 Вт\r\nБыстрая зарядка\r\n нет\r\nПоддержка беспроводной зарядки\r\n нет\r\nПоддержка беспроводной реверсивной зарядки\r\n нет\r\nВремя работы в режиме разговора \r\n 29.8 ч\r\nВремя работы при прослушивании музыки\r\n 135.3 ч\r\nВремя работы при воспроизведении видео\r\n 16.6 ч\r\nВремя работы в режиме ожидания \r\n 575 ч\r\nДополнительная информация\r\nБиометрическая защита \r\n распознавание лица, сканер отпечатков пальцев (сбоку корпуса)\r\nНаушники в комплекте\r\n нет\r\nЗарядное устройство в комплекте\r\n есть\r\nКомплектация\r\n документация, зарядное устройство, кабель USB Type-C, ещё\r\nГабариты и вес\r\nШирина\r\n 76.3 мм\r\nВысота\r\n 168.4 мм\r\nТолщина\r\n 8.3 мм\r\nВес смартфона\r\n 199 г', NULL, NULL, NULL, 15999.90, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('admin','user') COLLATE utf8mb4_general_ci DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, '114', '114', 'user'),
(2, '123', '$2b$10$D5xDfPrUa0DyE.hNs47FfOs/RbBvSvhpowi8RKzprMZegjDWavzt.', 'user'),
(3, '777', '$2b$10$/tIMuTgDUC6gRaLe4rcJWOglqPg5ETNXcTjW8WAg9Wm.LnEbDDvFy', 'admin'),
(4, '999', '$2b$10$1Y3ok2QcTG2vTmUhMRj22.qnkZrWCN26vkmuZuWro4tDUy6uL/x7.', 'user');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recommended_section1` (`recommended_section1`),
  ADD KEY `recommended_section2` (`recommended_section2`),
  ADD KEY `recommended_section3` (`recommended_section3`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `images`
--
ALTER TABLE `images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`recommended_section1`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`recommended_section2`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`recommended_section3`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `products_ibfk_4` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
