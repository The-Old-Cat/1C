
//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура УстановитьВидимость()
	ТонкийКлиент = Объект.СистемныйБлокТонкийКлиент;
	
	Элементы.Страницы.Видимость = НЕ ТонкийКлиент;
	Элементы.ОперционнаяСистема.Видимость = НЕ ТонкийКлиент;
	Элементы.Устройства.Видимость = НЕ ТонкийКлиент;
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ТонкийКлиентПриИзменении(Элемент)
	УстановитьВидимость()
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПриОткрытии(Отказ)
УстановитьВидимость();
КонецПроцедуры

&НаСервере
Процедура ВидОборудованияПриИзмененииНаСервере()
	Если Объект.ВидыОборудования = Справочники.ВидыОборудования.СистемныйБлокТонкийКлиент Тогда
    Объект.СистемныйБлокТонкийКлиент = Истина;
  КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВидОборудованияПриИзменении(Элемент)
	ВидОборудованияПриИзмененииНаСервере();
	УстановитьВидимость();
КонецПроцедуры
