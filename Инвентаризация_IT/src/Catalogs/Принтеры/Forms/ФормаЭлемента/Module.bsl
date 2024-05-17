//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ТипПодключенияПриИзменении(Элемент)
  // Получаем выбранное значение перечисления
  ВыбранноеЗначение = Элемент.Значение;

  // Объявляем переменную для хранения значения перечисления "TCP/IP"
  ЗначениеTCPIP = Неопределено;

  // Вызываем серверную процедуру для получения значения перечисления
  ПолучитьЗначениеTCPIP(ЗначениеTCPIP);

  // Проверяем, выбрано ли значение "TCP/IP"
  Если ВыбранноеЗначение = ЗначениеTCPIP Тогда

    // Устанавливаем видимость реквизита "IPАдрес" в Истина
    Элементы.IPАдрес.Видимость = Истина;

  Иначе

    // Если выбрано другое значение или значение не выбрано,
    // устанавливаем видимость реквизита "IPАдрес" в Ложь
    Элементы.IPАдрес.Видимость = Ложь;

  КонецЕсли;
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура ПолучитьЗначениеTCPIP(Результат)
  // Получаем значение перечисления "TCP/IP" на сервере
  Результат = Перечисления.ТипПодключенияПринтера.TCP_IP; // Обрати внимание на заглавные буквы
КонецПроцедуры