
//@skip-check module-structure-method-in-regions
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Получаем переданное значение из параметров формы
    //@skip-check optional-form-parameter-access
    Если Параметры.Свойство("УвольняемыйСотрудник") Тогда
        УвольняемыйСотрудник = Параметры.УвольняемыйСотрудник;
    КонецЕсли;
    Объект.УвольняемыйСотрудник = УвольняемыйСотрудник;
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
// Функция возвращает массив ссылок на документы "РабочиеМеста", где указан переданный сотрудник
Функция ПолучитьСписокРабочихМестСотрудника(Сотрудник)
    // Создаем объект запроса
    Запрос = Новый Запрос;
    // Устанавливаем текст запроса
    Запрос.Текст =
    "ВЫБРАТЬ
    |    РабочиеМеста.Ссылка
    |ИЗ
    |    Документ.РабочиеМеста КАК РабочиеМеста
    |ГДЕ
    |    РабочиеМеста.Ответственный = &Сотрудник";

    // Устанавливаем параметр запроса "Сотрудник"
    Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
    // Выполняем запрос
    РезультатЗапроса = Запрос.Выполнить();

    // Создаем массив для хранения ссылок на документы
    СписокРабочихМест = Новый Массив;
    // Если запрос вернул результат
    Если Не РезультатЗапроса.Пустой() Тогда
        // Получаем выборку из результата запроса
        Выборка = РезультатЗапроса.Выбрать();
        // Перебираем все строки выборки
        Пока Выборка.Следующий() Цикл
            // Добавляем ссылку на документ в массив
            СписокРабочихМест.Добавить(Выборка.Ссылка);
        КонецЦикла;
    КонецЕсли;
    // Возвращаем массив ссылок на документы
    Возврат СписокРабочихМест;
КонецФункции

//@skip-check module-structure-method-in-regions
&НаСервере
// Функция возвращает подразделение из документа "РабочиеМеста" по переданной ссылке
Функция ПолучитьПодразделениеИзДокументаРабочиеМеста(РабочееМесто)
    // Создаем объект запроса
    Запрос = Новый Запрос;
    // Устанавливаем текст запроса
    Запрос.Текст =
    "ВЫБРАТЬ
    |    РабочиеМеста.Подразделение
    |ИЗ
    |    Документ.РабочиеМеста КАК РабочиеМеста
    |ГДЕ
    |    РабочиеМеста.Ссылка = &РабочееМесто";

    // Устанавливаем параметр запроса "РабочееМесто"
    Запрос.УстановитьПараметр("РабочееМесто", РабочееМесто);
    // Выполняем запрос
    РезультатЗапроса = Запрос.Выполнить();

    // Если запрос вернул результат
    Если Не РезультатЗапроса.Пустой() Тогда
        // Получаем выборку из результата запроса
        Выборка = РезультатЗапроса.Выбрать();
        // Если в выборке есть строки
        Если Выборка.Следующий() Тогда
            // Возвращаем значение подразделения из текущей строки выборки
            Возврат Выборка.Подразделение;
        КонецЕсли;
    КонецЕсли;
    // Если подразделение не найдено, возвращаем Неопределено
    Возврат Неопределено;
КонецФункции

//@skip-check module-structure-method-in-regions
&НаСервере
// Функция возвращает подразделение сотрудника
Функция ПолучитьПодразделениеСотрудника(Сотрудник)
    // Если сотрудник не передан, возвращаем Неопределено
    Если Сотрудник = Неопределено Тогда
        Возврат Неопределено;
    КонецЕсли;
    // Возвращаем подразделение сотрудника
    //@skip-check reading-attribute-from-database
    Возврат Сотрудник.Подразделение;
КонецФункции

//@skip-check module-structure-method-in-regions
&НаКлиенте
// Процедура заполняет поля формы данными увольняемого сотрудника
Процедура ЗаполнениеПолей()
    // Получаем увольняемого сотрудника
    УвольняемыйСотрудник = Объект.УвольняемыйСотрудник;
    // Если сотрудник выбран
    Если УвольняемыйСотрудник <> Неопределено Тогда
        // Получаем подразделение сотрудника
        Подразделение = ПолучитьПодразделениеСотрудника(УвольняемыйСотрудник);
        // Заполняем реквизит "Подразделение" на форме
        Объект.Подразделение = Подразделение;
    Иначе
        // Очищаем реквизит "Подразделение", если сотрудник не выбран
        Объект.Подразделение = Неопределено;
    КонецЕсли;
    // Получаем список рабочих мест увольняемого сотрудника
    СписокРабочихМест = ПолучитьСписокРабочихМестСотрудника(УвольняемыйСотрудник);
    // Заполняем табличную часть "РабочиеМеста"
    ЗаполнитьТабличнуюЧастьРабочиеМеста(СписокРабочихМест);
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
// Обработчик события "ПриИзменении" для поля "УвольняемыйСотрудник"
Процедура УвольняемыйСотрудникПриИзменении(Элемент)
    // Вызываем процедуру заполнения полей формы
    ЗаполнениеПолей();
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
// Обработчик события "ПриОткрытии" формы
Процедура ПриОткрытии(Отказ)
    // Вызываем процедуру заполнения полей формы
    ЗаполнениеПолей();
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
// Процедура заполняет табличную часть "РабочиеМеста" 
Процедура ЗаполнитьТабличнуюЧастьРабочиеМеста(СписокРабочихМест)
    // Получаем табличную часть "РабочиеМеста"
    ТЧРабочиеМеста = Объект.РабочиеМеста;
	ТЧРабочиеМеста.Очистить();
    // Перебираем все ссылки на документы "РабочиеМеста" в переданном массиве
    Для Каждого РабочееМесто Из СписокРабочихМест Цикл
        // Добавляем новую строку в табличную часть
        НоваяСтрока = ТЧРабочиеМеста.Добавить();
        // Устанавливаем ссылку на документ "РабочиеМеста" в новой строке
        НоваяСтрока.РабочееМесто = РабочееМесто;

        // Получаем подразделение из документа "РабочиеМеста"
        //@skip-check query-in-loop
        Подразделение = ПолучитьПодразделениеИзДокументаРабочиеМеста(РабочееМесто);
        // Устанавливаем подразделение в новой строке
        НоваяСтрока.Подразделение = Подразделение;
    КонецЦикла;
КонецПроцедуры



