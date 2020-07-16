-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 16 2020 г., 21:36
-- Версия сервера: 5.6.41
-- Версия PHP: 7.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `iactive`
--

-- --------------------------------------------------------

--
-- Структура таблицы `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `phone` bigint(11) NOT NULL,
  `datetime_first_message` datetime NOT NULL,
  `datetime_last_message` datetime NOT NULL,
  `messages_count` int(11) NOT NULL,
  `is_banned` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `authors`
--

INSERT INTO `authors` (`id`, `phone`, `datetime_first_message`, `datetime_last_message`, `messages_count`, `is_banned`) VALUES
(1, 2147483647, '2020-07-13 11:23:06', '2020-07-13 11:23:06', 1, 0),
(10, 7999999999, '2020-07-13 17:39:05', '2020-07-13 18:58:07', 2, 1),
(14, 7999999998, '2020-07-13 18:25:40', '2020-07-13 18:25:40', 1, 0),
(15, 7999999989, '2020-07-13 18:57:25', '2020-07-13 18:58:07', 2, 0),
(18, 7999999969, '2020-07-15 00:13:10', '2020-07-15 00:13:10', 1, 0),
(19, 7999999469, '2020-07-16 12:03:59', '2020-07-16 12:45:52', 3, 0),
(23, 7999999369, '2020-07-16 13:06:04', '2020-07-16 13:06:04', 1, 0),
(27, 7999999169, '2020-07-16 13:36:59', '2020-07-16 13:36:59', 1, 0),
(28, 7999999269, '2020-07-16 13:43:05', '2020-07-16 13:43:05', 1, 0),
(31, 7999999459, '2020-07-16 13:45:57', '2020-07-16 13:45:57', 1, 0),
(32, 7999999479, '2020-07-16 13:54:46', '2020-07-16 13:54:46', 1, 0),
(33, 7999999499, '2020-07-16 14:00:11', '2020-07-16 14:00:11', 1, 0),
(34, 7999999449, '2020-07-16 14:00:21', '2020-07-16 14:04:03', 2, 0),
(35, 7959998449, '2020-07-16 20:32:23', '2020-07-16 20:32:23', 1, 0),
(36, 7979998449, '2020-07-16 20:34:54', '2020-07-16 21:22:18', 4, 0),
(37, 797998449, '2020-07-16 21:13:07', '2020-07-16 21:22:18', 2, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `content` varchar(10000) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `author_id`, `datetime`, `content`, `is_deleted`) VALUES
(1, 1, '2020-07-13 11:23:06', 'first message', 1),
(4, 14, '2020-07-13 18:25:40', 'Привет!', 1),
(5, 10, '2020-07-13 18:57:25', 'Как ваши дела?', 0),
(6, 15, '2020-07-13 18:57:25', 'Привет Всем!', 1),
(7, 10, '2020-07-13 18:58:07', 'Кто здесь?', 0),
(8, 15, '2020-07-13 18:58:07', 'Привет Всем!', 0),
(13, 18, '2020-07-15 00:13:10', 'Седьмое', 0),
(14, 19, '2020-07-16 12:03:59', 'New message', 1),
(18, 19, '2020-07-16 12:34:43', 'повторное сообщение', 0),
(19, 19, '2020-07-16 12:45:52', 'повторное сообщение', 0),
(20, 19, '2020-07-16 12:46:34', 'повторное сообщение', 0),
(22, 23, '2020-07-16 13:06:04', 'Тестовое сообщение', 0),
(25, 27, '2020-07-16 13:36:59', 'Один запрос', 0),
(26, 28, '2020-07-16 13:43:05', 'Another text', 0),
(27, 32, '2020-07-16 13:54:46', 'Another text 2', 0),
(28, 33, '2020-07-16 14:00:11', 'Another text 2', 0),
(29, 34, '2020-07-16 14:00:21', 'Another text 2', 1),
(30, 34, '2020-07-16 14:04:03', 'Another text 2', 0),
(31, 34, '2020-07-16 17:04:28', 'Another text 2', 1),
(32, 35, '2020-07-16 20:32:23', 'Another te', 0),
(33, 35, '2020-07-16 20:32:23', 'xt 2', 0),
(34, 36, '2020-07-16 20:35:15', 'Another long text!', 0),
(35, 36, '2020-07-16 20:37:30', 'Another lo', 0),
(36, 36, '2020-07-16 20:37:30', 'ng text!', 0),
(37, 36, '2020-07-16 21:20:26', 'Short text!', 0),
(38, 37, '2020-07-16 21:20:26', 'Контрольное сообщение.', 0),
(39, 36, '2020-07-16 21:22:18', 'Short text!', 0),
(40, 37, '2020-07-16 21:22:18', 'Контрольное сообщение.', 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author_id` (`author_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
