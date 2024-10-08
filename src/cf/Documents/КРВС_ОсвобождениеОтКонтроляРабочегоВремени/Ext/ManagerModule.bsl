﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область Проведение

// Инициализация данных документа для последующего формирования движений.
// 
// Параметры:
//  ДокументСсылка - ДокументСсылка.ИНК_ПриемБанкнот - Документ ссылка
//  ДополнительныеСвойства - Структура - Дополнительные свойства
//  Регистры - Неопределено - Регистры
Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	////////////////////////////////////////////////////////////////////////////
	// Создадим запрос инициализации движений

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
	////////////////////////////////////////////////////////////////////////////
	// Сформируем текст запроса

	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапросаТаблицаОсвобожденияОтКонтроляРабочегоВремени(Запрос, ТекстыЗапроса, Регистры);

	ПроведениеСерверУТ.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса,
		ДополнительныеСвойства.ТаблицыДляДвижений, Истина);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

Функция ТекстЗапросаТаблицаОсвобожденияОтКонтроляРабочегоВремени(Запрос, ТекстыЗапроса, Регистры)

	ИмяРегистра = "КРВС_ОсвобожденияОтКонтроляРабочегоВремени";
	
	Если Не ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	тСотрудники.Ссылка КАК Регистратор,
	|	тСотрудники.Ссылка.Дата КАК Период,
	|	тСотрудники.Ссылка.Организация КАК Организация,
	|	тСотрудники.Сотрудник КАК Сотрудник,
	|	тСотрудники.ДатаНачала КАК ДатаНачала,
	|	тСотрудники.ДатаОкончания КАК ДатаОкончания
	|ИЗ
	|	Документ.КРВС_ОсвобождениеОтКонтроляРабочегоВремени.Сотрудники КАК тСотрудники
	|ГДЕ
	|	тСотрудники.Ссылка = &Ссылка";

	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);

	Возврат ТекстЗапроса;	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли