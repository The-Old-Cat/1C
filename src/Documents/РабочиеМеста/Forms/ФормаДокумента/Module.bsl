 //@skip-check module-structure-method-in-regions
 &НаСервере
Функция НайтиКомпьютер(ИмяПК)
  Возврат Справочники.Компьютеры.НайтиПоНаименованию(ИмяПК);
КонецФункции
 
//@skip-check module-structure-method-in-regions
&НаСервере
Функция ПолучитьДанныеКомпьютера(Компьютер)
	
	ДанныеКомпьютера = Новый Структура;
	
	ДанныеКомпьютера.Вставить("ОперационнаяСистема", Компьютер.ОперационнаяСистема);
  	ДанныеКомпьютера.Вставить("Процессор", Компьютер.Процессор);
  	ДанныеКомпьютера.Вставить("ТипОЗУ", Компьютер.ТипОЗУ);
	ДанныеКомпьютера.Вставить("КоличествоОЗУ", Компьютер.КоличествоОЗУ);
	
	Возврат ДанныеКомпьютера;
	
КонецФункции


//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПКИмяПКПриИзменении(Элемент)
	Компьютер = Элементы.ПК.ТекущиеДанные;   
	
	ОбъектКомпьютера = НайтиКомпьютер(Компьютер.ИмяПК); 
	
	// Если компьютер найден, получаем данные
  Если ОбъектКомпьютера <> Неопределено Тогда
    
    // Получаем структуру с данными компьютера
    ДанныеКомпьютера = ПолучитьДанныеКомпьютера(ОбъектКомпьютера);
    
    // Заполняем реквизиты табличной части
    Компьютер.ОперационнаяСистема = ДанныеКомпьютера.ОперационнаяСистема;
    Компьютер.Процессор = ДанныеКомпьютера.Процессор;
    Компьютер.ТипОЗУ = ДанныеКомпьютера.ТипОЗУ;
    Компьютер.КоличествоОЗУ = ДанныеКомпьютера.КоличествоОЗУ;
    
  КонецЕсли;

КонецПроцедуры