
//@skip-check module-structure-method-in-regions
&НаСервере
Функция ПолучитьЗначения(ЗначениеПеречисления)
	ЗначениеПеречисления = Перечисления.ТипПодключенияПринтера.TCP_IP;
	Возврат ЗначениеПеречисления;
КонецФункции	

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ТипПодключенияПриИзменении(Элемент)
	// Получаем выбранное значение перечисления
    ВыбранноеЗначение = Элемент.Значение;

	ЗначениеПеречисления = ПолучитьЗначения(ВыбранноеЗначение);

    // Проверяем, выбрано ли значение "TCP/IP"
    Если ВыбранноеЗначение = ЗначениеПеречисления Тогда

        // Устанавливаем видимость реквизита "IPАдрес" в Истина
        Элементы.IPАдрес.Видимость = Истина;

    Иначе

        // Если выбрано другое значение или значение не выбрано, 
        // устанавливаем видимость реквизита "IPАдрес" в Ложь
        Элементы.IPАдрес.Видимость = Ложь;

    КонецЕсли;
КонецПроцедуры

