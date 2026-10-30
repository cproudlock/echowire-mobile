// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fluxer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class FluxerLocalizationsBg extends FluxerLocalizations {
  FluxerLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get reconnectingTitle => 'Сбъркахме!';

  @override
  String get chatJumpToPresent => 'Към най-новите';

  @override
  String get chatViewingOlderMessages => 'Преглеждаш по-стари съобщения';

  @override
  String get chatNewMessagesBarJumpToFirstUnread =>
      'Към първото непрочетено съобщение';

  @override
  String get chatNewMessagesBarMarkAsRead => 'Маркирай като прочетено';

  @override
  String get chatNewMessagesBarMarkRead => 'Маркирай като прочетено';

  @override
  String chatNewMessagesBarNewMessagesSinceEstimated(
    int unreadCount,
    String compactTime,
  ) {
    final intl.NumberFormat unreadCountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String unreadCountString = unreadCountNumberFormat.format(
      unreadCount,
    );

    return '$unreadCountString+ нови съобщения от $compactTime';
  }

  @override
  String chatNewMessagesBarNewMessagesSince(
    int unreadCount,
    String compactTime,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount нови съобщения',
      one: '$unreadCount ново съобщение',
    );
    return '$_temp0 от $compactTime';
  }

  @override
  String chatNewMessagesBarNewSinceEstimated(
    int unreadCount,
    String shortTime,
  ) {
    final intl.NumberFormat unreadCountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String unreadCountString = unreadCountNumberFormat.format(
      unreadCount,
    );

    return '$unreadCountString+ нови от $shortTime';
  }

  @override
  String chatNewMessagesBarNewSince(int unreadCount, String shortTime) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount нови',
      one: '$unreadCount ново',
    );
    return '$_temp0 от $shortTime';
  }

  @override
  String get reconnectingBody =>
      'Нещо не е наред с инстанцията.\nТрябва да се оправи за секунда!';

  @override
  String get gatewayReconnectingToast => 'Свързване отново…';

  @override
  String get gatewayReconnectTryAgain => 'Опитай отново';

  @override
  String get gatewayConnectedToast => 'Свързан';

  @override
  String get sessionExpiredToast =>
      'Вашата сесия е изтекла. Моля, влезте отново.';

  @override
  String splashStartupFailed(String error) {
    return 'Неуспешно стартиране: $error';
  }

  @override
  String get retry => 'Опитай отново';

  @override
  String get splashConnectionLost => 'Връзката е изгубена';

  @override
  String get splashViewOnStatusPage => 'Преглед на страницата за състоянието';

  @override
  String get splashConnectionIssuesPrompt => 'Проблеми с връзката?';

  @override
  String get splashStatusPageLink => 'Страница със състоянието';

  @override
  String get splashReadIncident => 'Прочети инцидента';

  @override
  String get splashIncidentHistory => 'История на инцидентите';

  @override
  String get nagbarLearnMore => 'Научете повече';

  @override
  String nagbarMaintenanceScheduled(String localizedTime, String duration) {
    return 'Планирана е поддръжка за $localizedTime. Очаквана продължителност: $duration.';
  }

  @override
  String nagbarMaintenanceInProgress(String duration) {
    return 'Извършва се поддръжка. Очаквана продължителност: $duration.';
  }

  @override
  String get nagbarMaintenanceComplete => 'Поддръжката приключи.';

  @override
  String nagbarUnclaimedAccountMessage(String displayName) {
    return 'Здравейте, $displayName, заявете профила си, за да не загубите достъп.';
  }

  @override
  String nagbarEmailVerificationMessage(String displayName) {
    return 'Здравейте, $displayName, моля, потвърдете имейл адреса си.';
  }

  @override
  String get nagbarOpenSettings => 'Отваряне на настройките';

  @override
  String get systemPermissionSettingsTitle => 'Разреши разрешение';

  @override
  String get systemPermissionSettingsOpenSettings => 'Отваряне на настройките';

  @override
  String systemPermissionMicrophoneMessage(String productName) {
    return '$productName няма достъп до микрофона ви. Можете да го активирате в настройките за поверителност на устройството си.';
  }

  @override
  String systemPermissionCameraMessage(String productName) {
    return '$productName няма достъп до камерата ви. Можете да я активирате в настройките за поверителност на устройството си.';
  }

  @override
  String systemPermissionPhotosMessage(String productName) {
    return '$productName няма достъп до вашата библиотека със снимки. Можете да я активирате в настройките за поверителност на устройството си.';
  }

  @override
  String systemPermissionNotificationsMessage(String productName) {
    return '$productName няма разрешение за изпращане на известия. Можете да го активирате в настройките на устройството си.';
  }

  @override
  String nagbarPremiumGracePeriod(String productName, String graceDate) {
    return 'Абонаментът ви не беше подновен, но все още имате достъп до предимствата на $productName до $graceDate. Предприемете действия сега, за да не загубите всички предимства.';
  }

  @override
  String nagbarPremiumExpired(String productName) {
    return 'Вашият абонамент за $productName е изтекъл. Подновете сега, за да запазите предимствата си.';
  }

  @override
  String get nagbarManageSubscription => 'Управление на абонамент';

  @override
  String nagbarPremiumOnboardingDefault(
    String productFullName,
    String productName,
  ) {
    return 'Добре дошли в $productFullName. Разгледайте предимствата на $productName и управлявайте абонамента си.';
  }

  @override
  String nagbarViewPremiumFeatures(String productName) {
    return 'Вижте функциите на $productName';
  }

  @override
  String get nagbarGiftInventoryOne =>
      'Имате нов код за подарък, който чака в инвентара ви с подаръци.';

  @override
  String nagbarGiftInventoryMany(int count) {
    return 'Имате $count нови кода за подаръци, които чакат в инвентара ви с подаръци.';
  }

  @override
  String get nagbarViewGiftInventory => 'Преглед на инвентара с подаръци';

  @override
  String get nagbarVisionaryMfa =>
      'Активирайте двуфакторна автентикация, за да защитите своя Visionary акаунт.';

  @override
  String get nagbarEnableMfa => 'Активирай 2FA';

  @override
  String get nagbarTermsAcceptance =>
      'Актуализирахме нашите условия. Моля, прегледайте ги и ги приемете, за да продължите.';

  @override
  String get nagbarReviewTerms => 'Преглед на условията';

  @override
  String nagbarGuildMembershipCta(String communityName) {
    return 'Присъединете се към $communityName, за да разговаряте с екипа и да сте в крак с новостите.';
  }

  @override
  String nagbarJoinCommunity(String communityName) {
    return 'Присъединяване към $communityName';
  }

  @override
  String get nagbarPushNotification =>
      'Разрешете известията, за да не пропускате съобщения и споменавания.';

  @override
  String get nagbarEnableNotifications => 'Включване на известията';

  @override
  String get welcomeBack => 'Добре дошъл отново';

  @override
  String get email => 'Имейл';

  @override
  String get emailInvalid => 'Моля, въведете валиден имейл адрес.';

  @override
  String get password => 'Парола';

  @override
  String get forgotPassword => 'Забравена парола?';

  @override
  String get logIn => 'Вход';

  @override
  String get logInWithPasskey => 'Влезте с пропуск';

  @override
  String continueWithSso(String provider) {
    return 'Продължи с $provider';
  }

  @override
  String get organizationSsoProvider =>
      'Влезте с доставчика на единично влизане на вашата организация.';

  @override
  String get failedToStartSso => 'Неуспешно стартиране на SSO';

  @override
  String get ssoCancelled => 'Влизането чрез SSO беше отменено';

  @override
  String preferSso(String provider) {
    return 'Предпочитате ли да използвате SSO? Продължете с $provider.';
  }

  @override
  String get needAccountPrompt => 'Нуждаете се от акаунт? ';

  @override
  String get register => 'Регистрация';

  @override
  String get orDivider => 'ИЛИ';

  @override
  String get cancel => 'Отказ';

  @override
  String get ipAuthCheckEmail => 'Проверете имейла си';

  @override
  String ipAuthDescription(String email) {
    return 'Изпратихме имейл с връзка за оторизиране на този вход. Моля, отворете входящата си поща на адрес $email.';
  }

  @override
  String get ipAuthConnectionLost => 'Връзката е изгубена';

  @override
  String get ipAuthConnectionLostDescription =>
      'Изгубихме връзката, докато чакахме оторизация. Моля, опитайте отново.';

  @override
  String get ipAuthLinkExpired => 'Връзката за влизане е изтекла';

  @override
  String get ipAuthLinkExpiredDescription =>
      'Тази връзка за оторизация е изтекла. Моля, влезте отново.';

  @override
  String get ipAuthResendEmail => 'Изпращане отново';

  @override
  String get ipAuthResent => 'Изпратено наново';

  @override
  String ipAuthResendCountdown(int seconds) {
    return '$seconds сек.';
  }

  @override
  String get back => 'Назад';

  @override
  String get next => 'Напред';

  @override
  String get create => 'Създаване';

  @override
  String get mfaTitle => 'Двуфакторно удостоверяване';

  @override
  String get mfaChooseMethod => 'Изберете метод за проверка';

  @override
  String get mfaMethodTotp => 'Приложение за удостоверяване';

  @override
  String get mfaMethodWebauthn => 'Защитен ключ / Парола';

  @override
  String get mfaTotpDescription =>
      'Въведете 6-цифрения код от приложението си за удостоверяване или един от резервните си кодове.';

  @override
  String get mfaCodeLabel => 'Код';

  @override
  String get mfaTryAnotherMethod => 'Опитай друг метод';

  @override
  String get mfaUseSecurityKey => 'Опитай със защитен ключ/passkey вместо това';

  @override
  String get accountSelectorTitle => 'Изберете профил';

  @override
  String get accountSelectorDescription =>
      'Изберете профил, за да продължите, или добавете друг.';

  @override
  String get accountAdd => 'Добавяне на профил';

  @override
  String get accountRemoveDescription =>
      'Това ще премахне запазената сесия за този акаунт.';

  @override
  String accountSignOutTitle(String identifier) {
    return 'Да излезеш ли от $identifier?';
  }

  @override
  String get accountExpired => 'Изтекло';

  @override
  String accountSessionExpired(String identifier) {
    return 'Сесията за $identifier е изтекла. Моля, влезте отново.';
  }

  @override
  String get accountManageTitle => 'Управление на профили';

  @override
  String get accountSwitchFailed =>
      'Неуспешно превключване на профили. Опитайте отново.';

  @override
  String get profileTabMenuSwitchAccounts => 'Смени профила';

  @override
  String get statusChangeSheetTitle => 'Задаване на статус';

  @override
  String get statusOnlineStatusSection => 'Онлайн статус';

  @override
  String get statusOnline => 'Онлайн';

  @override
  String get statusIdle => 'Неактивен';

  @override
  String get statusDnd => 'Не ме безпокойте';

  @override
  String get statusInvisible => 'Невидим';

  @override
  String get statusOffline => 'Извън линия';

  @override
  String get statusUntilIChangeIt => 'Докато не го променя';

  @override
  String get statusDontClear => 'Без изчистване';

  @override
  String get statusFor10Seconds => 'За 10 секунди';

  @override
  String get statusClearAfter10Seconds => '10 секунди';

  @override
  String get statusClearAfter15Minutes => '15 минути';

  @override
  String get statusClearAfter30Minutes => '30 минути';

  @override
  String get statusClearAfter1Hour => '1 час';

  @override
  String get statusClearAfter3Hours => '3 часа';

  @override
  String get statusClearAfter4Hours => '4 часа';

  @override
  String get statusClearAfter8Hours => '8 часа';

  @override
  String get statusClearAfter24Hours => '24 часа';

  @override
  String get statusClearAfter3Days => '3 дни';

  @override
  String get statusDndDescription =>
      'Няма да получавате известия на компютъра си';

  @override
  String get statusInvisibleDescription => 'Ще изглеждате офлайн';

  @override
  String get customStatusSetTitle => 'Задаване на статус';

  @override
  String get customStatusCurrentHint => 'Персонализиран статус';

  @override
  String get customStatusClear => 'Изчистване на персонализиран статус';

  @override
  String get customStatusPlaceholder => 'Какво става?';

  @override
  String get customStatusChooseEmoji => 'Избери емоджи';

  @override
  String get customStatusClearAfter => 'Изчистване след';

  @override
  String get customStatusSave => 'Запазване';

  @override
  String get accountActive => 'Активен акаунт';

  @override
  String get signOut => 'Изход';

  @override
  String get suspendedPermanentTitle => 'Акаунтът е перманентно блокиран';

  @override
  String get suspendedTemporaryTitle => 'Акаунтът е временно блокиран';

  @override
  String get suspendedPermanentDescription =>
      'Вашият акаунт е перманентно блокиран за нарушаване на нашите Условия за ползване.';

  @override
  String get suspendedTemporaryDescription =>
      'Вашият акаунт е временно блокиран. Ще можете да влезете в акаунта си, след като периодът на блокиране приключи.';

  @override
  String get suspendedIssuedAt => 'Издадено';

  @override
  String get suspendedEndsAt => 'Край';

  @override
  String get suspendedDuration => 'Продължителност';

  @override
  String get suspendedPermanent => 'Постоянно';

  @override
  String get suspendedReason => 'Причина';

  @override
  String get suspendedAppealDeadline => 'Краен срок за обжалване';

  @override
  String suspendedDeletionWarning(String date) {
    return 'Профилът ви е насрочен за изтриване на $date.';
  }

  @override
  String get suspendedRecheck => 'Проверка за актуализации';

  @override
  String suspendedRecheckCooldown(int seconds) {
    return 'Провери отново след $seconds сек.';
  }

  @override
  String get suspendedBackToLogin => 'Обратно към влизане';

  @override
  String get suspendedAppealTitle => 'Жалба';

  @override
  String get suspendedAppealHint =>
      'Обяснете защо мярката ви трябва да бъде преразгледана (минимум 50 знака)...';

  @override
  String get suspendedAppealSubmit => 'Изпрати обжалване';

  @override
  String get suspendedAppealPending => 'Чака преглед';

  @override
  String get suspendedAppealAccepted => 'Прието обжалване';

  @override
  String get suspendedAppealRejected => 'Отхвърлена жалба';

  @override
  String get suspendedAppealAcceptedDescription =>
      'Вашата жалба е приета и акаунтът ви е възстановен.';

  @override
  String get suspendedSignIn => 'Влезте в профила си';

  @override
  String get forgotPasswordTitle => 'Забравена парола?';

  @override
  String get forgotPasswordDescription =>
      'Въведете имейл адреса си и ние ще ви изпратим линк за нулиране на паролата.';

  @override
  String get forgotPasswordSubmit => 'Изпращане на връзка за нулиране';

  @override
  String get forgotPasswordSentTitle => 'Проверете имейла си';

  @override
  String get forgotPasswordSentDescription =>
      'Изпратихме инструкции за нулиране на паролата на вашия имейл адрес. Моля, проверете входящата си поща и следвайте връзката, за да нулирате паролата си.';

  @override
  String get forgotPasswordBackToLogin => 'Върни се към влизане';

  @override
  String get resetPasswordTitle => 'Задаване на нова парола';

  @override
  String get resetPasswordDescription =>
      'Въведете новата си парола по-долу, за да завършите процеса на нулиране.';

  @override
  String get resetPasswordNewPassword => 'Нова парола';

  @override
  String get resetPasswordConfirm => 'Потвърдете новата парола';

  @override
  String get resetPasswordSubmit => 'Нулиране на парола';

  @override
  String get resetPasswordMismatch => 'Паролите не съвпадат.';

  @override
  String get recoverAccountTitle => 'Възстановете акаунта си';

  @override
  String get recoverAccountDescription =>
      'Въведете вашето потребителско име и ключ за възстановяване от комплекта си за възстановяване, след което изберете нова парола.';

  @override
  String get recoverAccountNoKit =>
      'Нямате комплект за възстановяване? Поискайте от администратор на този сървър връзка за нулиране на паролата.';

  @override
  String get recoveryKitTitle => 'Вашият комплект за възстановяване';

  @override
  String get recoveryKitCreatedDescription =>
      'Ако забравите паролата си, този комплект е единственият начин да влезете отново в акаунта си. Съхранявайте го на сигурно място, например в мениджър на пароли или като разпечатка.';

  @override
  String get recoveryKitReplacedDescription =>
      'Старият ви комплект за възстановяване вече не работи. Съхранявайте този нов на сигурно място.';

  @override
  String get recoveryKitRecoveredDescription =>
      'Паролата ви е нулирана. Старият ви комплект за възстановяване вече не работи. Съхранявайте този нов някъде на сигурно място.';

  @override
  String get recoveryKitWarning =>
      'Всеки с този ключ може да нулира паролата ви. Никога не го споделяйте.';

  @override
  String get recoveryKitKeyLabel => 'Ключ за възстановяване';

  @override
  String recoveryKitDocumentTitle(String productName) {
    return 'Резервен комплект на $productName';
  }

  @override
  String get recoveryKitDocumentIntro =>
      'Пазете тази страница на сигурно място. Ако забравите паролата си, можете да я използвате, за да влезете отново в профила си. Всеки, който има този ключ за възстановяване, може да нулира паролата ви, така че никога не го споделяйте.';

  @override
  String get recoveryKitInstanceLabel => 'Инстанция';

  @override
  String get recoveryKitCreatedAtLabel => 'Създадена';

  @override
  String get recoveryKitQrCaption =>
      'Сканирайте, за да отворите страницата за възстановяване с попълнени данни.';

  @override
  String get recoveryKitStepsTitle => 'Как да възстановите акаунта си';

  @override
  String recoveryKitStepOpen(String recoverUrl) {
    return 'Отидете на $recoverUrl или сканирайте QR кода.';
  }

  @override
  String get recoveryKitStepEnter =>
      'Въведете вашето потребителско име и този ключ за възстановяване.';

  @override
  String get recoveryKitStepPassword =>
      'Изберете нова парола. Ще получите нов комплект за възстановяване и този ще спре да работи.';

  @override
  String get recoveryKitBackupCodesTitle =>
      'Резервни кодове за двуфакторна автентикация';

  @override
  String get recoveryKitBackupCodesNote =>
      'Всеки код работи еднократно вместо приложението ви за удостоверяване.';

  @override
  String get recoveryKitBackupCodesFailed =>
      'Не успяхме да заредим резервните ви кодове.';

  @override
  String get recoveryKitIncludeBackupCodes =>
      'Включи резервните ми кодове за двуфакторно удостоверяване в запазеното изображение';

  @override
  String get recoveryKitCopy => 'Копирай';

  @override
  String get recoveryKitCopied => 'Ключът за възстановяване е копиран';

  @override
  String get recoveryKitSaveImage => 'Запази изображение';

  @override
  String get recoveryKitSaved => 'Комплектът за възстановяване е запазен';

  @override
  String get recoveryKitSavedToPhotos =>
      'Комплектът за възстановяване е запазен в снимките';

  @override
  String get recoveryKitSaveFailed =>
      'Комплектът за възстановяване не можа да бъде запазен. Опитай отново или копирай ключа.';

  @override
  String get recoveryKitAcknowledge =>
      'Съхраних комплекта си за възстановяване на сигурно място';

  @override
  String get recoveryKitCreateFailed =>
      'Не успяхме да създадем вашия комплект за възстановяване. Можете да създадете такъв по-късно в настройките на профила си.';

  @override
  String get recoveryKitSectionTitle => 'Комплект за възстановяване';

  @override
  String get recoveryKitSectionDescription =>
      'Позволява ви да нулирате паролата си, ако я забравите.';

  @override
  String get recoveryKitNone => 'Все още нямате комплект за възстановяване';

  @override
  String recoveryKitCreatedRelative(String time) {
    return 'Създадено $time';
  }

  @override
  String get recoveryKitCreate => 'Създай комплект за възстановяване';

  @override
  String get recoveryKitCreateNew => 'Създай нов комплект';

  @override
  String get recoveryKitReplaceTitle =>
      'Създаване на нов комплект за възстановяване?';

  @override
  String get recoveryKitReplaceDescription =>
      'Настоящият ви комплект спира да работи веднага щом бъде създаден нов.';

  @override
  String get recoveryKitReminderTitle => 'Запазете комплект за възстановяване';

  @override
  String get recoveryKitReminderBody =>
      'В профила ви няма имейл адрес. Ако забравите паролата си, комплектът за възстановяване е единственият начин да влезете отново. Отнема само минута.';

  @override
  String get registerUsernameSignInHint =>
      'Влизате с това потребителско име. Изберете такова, което ще запомните.';

  @override
  String get registerUsernameTaken => 'Това потребителско име вече е заето';

  @override
  String get registerUsernameAvailable => 'Това потребителско име е налично';

  @override
  String get claimAccountUsernameDescription =>
      'Заяви своя акаунт, като избереш потребителско име и парола. С тях ще влизаш в системата, така че избери такива, които ще помниш.';

  @override
  String get unclaimedAccountDescriptionUsername =>
      'Акаунтът ви все още не е заявен. Без потребителско име и парола няма да можете да влезете от други устройства и може да загубите достъп до акаунта си. Заявете акаунта си сега, за да го защитите.';

  @override
  String get addFriendUsernameOnlyHint => 'Потребителско име';

  @override
  String get registerTitle => 'Създаване на профил';

  @override
  String get registerDisplayName => 'Име за показване (по избор)';

  @override
  String get registerDisplayNameHint => 'Как да те наричат?';

  @override
  String get registerUsername => 'Потребителско име (по избор)';

  @override
  String get registerUsernameHint =>
      'Оставете празно за случайно потребителско име';

  @override
  String get registerUsernameTagHint =>
      'Ще бъде добавен автоматично 4-цифрен етикет, за да се гарантира уникалност';

  @override
  String get registerDateOfBirth => 'Дата на раждане';

  @override
  String get registerMonth => 'Месец';

  @override
  String get registerDay => 'Ден';

  @override
  String get registerYear => 'Година';

  @override
  String get registerConsentPrefix => 'Съгласен съм с ';

  @override
  String get registerConsentTerms => 'Условия за ползване';

  @override
  String get registerConsentAnd => ' и ';

  @override
  String get registerConsentPrivacy => 'Политика за поверителност';

  @override
  String get registerConfirmPassword => 'Потвърди паролата';

  @override
  String get registerSubmit => 'Създаване на профил';

  @override
  String get registerHaveAccount => 'Вече имате акаунт? ';

  @override
  String get registerPendingApproval =>
      'Заявката ви за акаунт чака одобрение. Можете да влезете, след като администратор я одобри.';

  @override
  String get registerClosed =>
      'Регистрацията в момента е затворена. Използвайте регистрационна връзка от администратор, за да създадете акаунт.';

  @override
  String get passkeyNoCredentials =>
      'Не са намерени пароли за това приложение. Вместо това влезте с имейл и парола.';

  @override
  String get passkeyDeviceNotSupported =>
      'Passkeys не се поддържат на това устройство.';

  @override
  String get passkeyDomainNotAssociated =>
      'Passkeys не са конфигурирани за това приложение. Вместо това влезте с имейл и парола.';

  @override
  String get passkeyTimeout =>
      'Изтече времето за удостоверяване с ключ за достъп. Моля, опитайте отново.';

  @override
  String get passkeyFailed =>
      'Неуспешна автентикация с пропуск. Моля, опитайте отново.';

  @override
  String get errorUnableToCreateAccount =>
      'Неуспешно създаване на акаунт. Моля, опитайте отново.';

  @override
  String get errorUnableToSignIn =>
      'Не може да се влезе в момента. Моля, опитайте отново.';

  @override
  String get errorServiceUnavailable =>
      'Тази инстанция е временно недостъпна. Опитайте отново след малко.';

  @override
  String get errorInvalidEmailOrPassword => 'Невалиден имейл или парола.';

  @override
  String get errorInvalidUsernameOrPassword =>
      'Невалидно потребителско име или парола.';

  @override
  String get errorUnableToSendResetLink =>
      'Не успяхме да изпратим връзка за нулиране. Моля, опитайте отново.';

  @override
  String get errorUnableToResetPassword =>
      'Не може да се нулира паролата. Моля, опитайте отново.';

  @override
  String get embedInviteJoin => 'Присъедини се към общността';

  @override
  String get embedInviteGoTo => 'Отиди в общността';

  @override
  String embedInviteOnline(String count) {
    return '$count онлайн';
  }

  @override
  String embedInviteMembers(String count) {
    return '$count членове';
  }

  @override
  String get embedInviteUnknownTitle => 'Невалидна покана';

  @override
  String get embedInviteUnknownSubtitle => 'Опитайте да поискате нова покана.';

  @override
  String get embedInviteUnavailable => 'Покана недостъпна';

  @override
  String get embedInviteJoinGroup => 'Присъединяване към групата';

  @override
  String get embedInviteAlreadyJoined => 'Вече сте член';

  @override
  String get embedInviteDisabled => 'Поканите са деактивирани';

  @override
  String get embedInvitePaused => 'Поканите за тази общност са на пауза.';

  @override
  String embedInvitePausedRaid(String productName) {
    return '$productName откри потенциална атака, така че новите потребители не могат да се присъединят в момента.';
  }

  @override
  String get inviteAcceptInvitesPausedTryAgain =>
      'Тази общност е спряла поканите. Може да опитате отново по-късно.';

  @override
  String inviteAcceptRaidInvitesPaused(String productName) {
    return '$productName засякохме потенциална атака в тази общност. Поканите са на пауза, така че нови потребители не могат да се присъединят в момента.';
  }

  @override
  String get inviteAcceptTitle => 'Поканени сте да се присъедините';

  @override
  String get inviteAcceptJoinButton => 'Присъедини се към общността';

  @override
  String get inviteAcceptGoToButton => 'Към общността';

  @override
  String get inviteAcceptInvitesPaused => 'Покани паузирани';

  @override
  String get inviteAcceptNotFoundTitle => 'Невалидна покана';

  @override
  String get inviteAcceptNotFoundDescription =>
      'Тази покана може да е изтекла или невалидна.';

  @override
  String get invalidDeepLinkTitle => 'Връзката не може да бъде отворена';

  @override
  String get invalidDeepLinkDescription =>
      'Връзката може да е невалидна, да е достъпна само в уеб или да нямате достъп. Проверете връзката и опитайте отново.';

  @override
  String get invalidDeepLinkGoHomeButton => 'Към начало';

  @override
  String get inviteAcceptJoinGroupButton => 'Присъединяване към групата';

  @override
  String inviteAcceptGroupDmDescription(String inviterName) {
    return 'Поканен си да се присъединиш към групов личен разговор от $inviterName';
  }

  @override
  String get inviteAcceptSomeone => 'някой';

  @override
  String get mentionUnknownChannel => 'неизвестен-канал';

  @override
  String get channelAccessDeniedTitle => 'Достъпът до канала е отказан';

  @override
  String get channelAccessDeniedDescription =>
      'Нямаш достъп до канала, където е изпратено това съобщение.';

  @override
  String get messageJumpLinkNoAccess => 'Няма достъп';

  @override
  String get okay => 'ОК';

  @override
  String get embedThemeTitle => 'Споделена тема';

  @override
  String get embedThemeWebOnly =>
      'Темите могат да се импортират само в уеб или настолната версия.';

  @override
  String get embedThemeImport => 'Импортиране на тема';

  @override
  String embedGiftVisionaryLifetime(String productName) {
    return 'Визионер (доживотно $productName)';
  }

  @override
  String embedGiftDurationDays(int count, String productName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дни $productName',
      one: '1 ден $productName',
    );
    return '$_temp0';
  }

  @override
  String embedGiftDurationWeeks(int count, String productName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count седмици $productName',
      one: '1 седмица $productName',
    );
    return '$_temp0';
  }

  @override
  String embedGiftDurationMonths(int count, String productName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count месеца $productName',
      one: '1 месец $productName',
    );
    return '$_temp0';
  }

  @override
  String embedGiftDurationYears(int count, String productName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count години $productName',
      one: '1 година $productName',
    );
    return '$_temp0';
  }

  @override
  String embedGiftFrom(String creatorTag) {
    return 'От $creatorTag';
  }

  @override
  String get embedGiftClaimHelp => 'Натиснете, за да получите подаръка си!';

  @override
  String get embedGiftAlreadyRedeemed => 'Вече е осребрено';

  @override
  String get embedGiftClaimAccountHelp =>
      'За да осребрите този подарък, заявете профила си.';

  @override
  String get embedGiftClaim => 'Вземи подарък';

  @override
  String get embedGiftClaimed => 'Подаръкът е получен';

  @override
  String get embedGiftClaimAccount => 'Влезте, за да осребрите';

  @override
  String get embedGiftUnknownTitle => 'Неизвестен подарък';

  @override
  String get embedGiftUnknownSubtitle =>
      'Този код за подарък е невалиден или вече е използван.';

  @override
  String get embedGiftUnavailable => 'Подаръкът не е наличен';

  @override
  String giftAcceptClaimSubscription(String productName) {
    return 'Поискай подаръка си, за да активираш своя $productName абонамент!';
  }

  @override
  String get giftAcceptAlreadyClaimed => 'Този подарък вече е приет.';

  @override
  String get giftAcceptMaybeLater => 'Може би по-късно';

  @override
  String get giftRedeemedToast => 'Подаръкът е осребрен!';

  @override
  String get giftRedeemInvalidTitle => 'Невалиден код за подарък';

  @override
  String get giftRedeemInvalidMessage =>
      'Този код е невалиден или вече е използван.';

  @override
  String get giftRedeemAlreadyRedeemedTitle => 'Подаръкът вече е осребрен';

  @override
  String get giftRedeemAlreadyRedeemedMessage => 'Този код вече е използван.';

  @override
  String get giftRedeemNotFoundTitle => 'Подаръкът не е намерен';

  @override
  String get giftRedeemNotFoundMessage => 'Този код не съществува.';

  @override
  String get giftRedeemFailedTitle => 'Неуспешно осребряване на подарък';

  @override
  String get giftRedeemFailedMessage =>
      'Подаръкът не можа да бъде осребрен. Опитайте отново.';

  @override
  String get giftVisionaryCannotRedeemTitle =>
      'Не можеш да осребриш този подарък';

  @override
  String get giftVisionaryCannotRedeemMessage =>
      'Акаунтите Visionary не могат да осребряват Reverb подаръци. Копирайте връзката, за да я споделите с приятел вместо това.';

  @override
  String get giftCopyLink => 'Копирай линк за подарък';

  @override
  String get privacySettings => 'Настройки за поверителност';

  @override
  String get privacyDirectMessages => 'Лични съобщения';

  @override
  String get privacyDirectMessagesDescription =>
      'Позволи лични съобщения от други членове в тази общност';

  @override
  String get privacyBotDirectMessages => 'Директни съобщения от бот';

  @override
  String get privacyBotDirectMessagesDescription =>
      'Позволи на ботове от тази общност да ти изпращат лични съобщения';

  @override
  String get privacyMutualDmsDisabled =>
      'Администраторите на общността са деактивирали получаването на лични съобщения само от взаимни членове в тази общност.';

  @override
  String get communityDebug => 'Относно общността';

  @override
  String get copiedToClipboard => 'Копирано в клипборда';

  @override
  String get notificationSettings => 'Настройки на известията';

  @override
  String notificationMuteGuild(String guildName) {
    return 'Без звук за $guildName';
  }

  @override
  String get notificationMuteDescription =>
      'Заглушаването на общност предотвратява появата на индикатори за непрочетени съобщения и известия, освен ако не сте споменати';

  @override
  String get notificationCommunitySettings =>
      'Настройки на известията за общността';

  @override
  String get notificationAllMessages => 'Всички съобщения';

  @override
  String get notificationOnlyMentions => 'Само споменавания';

  @override
  String get notificationNothing => 'Нищо';

  @override
  String get notificationSuppressEveryone => 'Потисни @everyone и @here';

  @override
  String get notificationSuppressRoles => 'Потисни всички споменавания на роли';

  @override
  String get notificationMobilePush => 'Мобилни известия по Push';

  @override
  String get notificationOverrides => 'Настройки на известията';

  @override
  String get notificationSelectChannel => 'Изберете канал или категория';

  @override
  String get notificationOnlyAtMentions => 'Само @споменавания';

  @override
  String get notificationMuteChannel => 'Заглуши канал';

  @override
  String get notificationUnmuteChannel => 'Вдигни заглушаването на канала';

  @override
  String get notificationUseCategoryDefault =>
      'Използвай категорията по подразбиране';

  @override
  String get notificationUseCommunityDefault =>
      'Използвай общи настройки на общността';

  @override
  String get notificationNoCategory => 'Няма категория';

  @override
  String get dmMarkAsRead => 'Маркирай като прочетено';

  @override
  String get dmMuteConversation =>
      'Изключване на известията за лично съобщение';

  @override
  String get dmUnmuteConversation => 'Включване на звука на лично съобщение';

  @override
  String get dmPinDm => 'Закачи лично съобщение';

  @override
  String get dmUnpinDm => 'Откачи лично съобщение';

  @override
  String get dmAlwaysShowInSidebar => 'Винаги показвай в страничната лента';

  @override
  String get dmRemoveFromAlwaysShown => 'Премахни от винаги показване';

  @override
  String get dmCloseDm => 'Затваряне на лично съобщение';

  @override
  String get dmCloseDmConfirmTitle => 'Затваряне на лично съобщение';

  @override
  String dmCloseDmConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да затворите личния си чат с $username? Винаги можете да го отворите отново по-късно.';
  }

  @override
  String get dmDeleteMyMessagesTitle =>
      'Да изтриете съобщенията си в този разговор?';

  @override
  String get dmDeleteMyMessagesDescription =>
      'Това ще изтрие за постоянно всяко съобщение, което някога сте изпратили в този разговор. Това действие не може да бъде отменено.';

  @override
  String get dmCopyChannelId => 'Копирай ID на канала';

  @override
  String get dmChannelIdCopied => 'Идентификаторът на канала е копиран';

  @override
  String get dmCopyUserId => 'Копирай ID на потребител';

  @override
  String get dmUserIdCopied => 'Потребителският идентификатор е копиран';

  @override
  String get dmViewProfile => 'Преглед на профила';

  @override
  String get dmVoiceCall => 'Започни гласово повикване';

  @override
  String get incomingVoiceCallTitle => 'Входящо гласово повикване';

  @override
  String get incomingVoiceCallAccept => 'Приемане';

  @override
  String get incomingVoiceCallDecline => 'Отхвърляне';

  @override
  String get incomingVoiceCallLabel => 'Входящо повикване';

  @override
  String get incomingVoiceCallIgnore => 'Игнориране';

  @override
  String get directVoiceCallNotEligible =>
      'Това обаждане не може да бъде стартирано в момента. Опитайте отново след малко.';

  @override
  String get voiceJoinCallFailed =>
      'Не успяхме да се свържем с това обаждане. Проверете връзката си и опитайте отново.';

  @override
  String get voiceJoinIncomingCallFailed =>
      'Не успяхме да се присъединим към този разговор. Проверете връзката си и опитайте отново.';

  @override
  String get incomingVoiceRingingUpdateFailed =>
      'Не успяхме да актуализираме това обаждане в сървъра. Проверете връзката си и опитайте отново.';

  @override
  String get dmAddNote => 'Добави бележка';

  @override
  String get dmEditGroup => 'Редактиране на групата';

  @override
  String get dmInviteToCommunity => 'Покана към общност';

  @override
  String get dmBlock => 'Блокиране';

  @override
  String get dmLeaveGroup => 'Напусни групата';

  @override
  String dmInviteSentFor(String communityName) {
    return 'Изпратена покана за $communityName';
  }

  @override
  String get dmInviteSendFailed =>
      'Поканата не можа да бъде изпратена. Опитай отново.';

  @override
  String dmGroupMemberCount(int count) {
    return '$count членове';
  }

  @override
  String get dmMuteFor15Min => 'За 15 минути';

  @override
  String get dmMuteFor30Min => 'За 30 минути';

  @override
  String get dmMuteFor1Hour => 'За 1 час';

  @override
  String get dmMuteFor3Hours => 'За 3 часа';

  @override
  String get dmMuteFor4Hours => 'За 4 часа';

  @override
  String get dmMuteFor8Hours => 'За 8 часа';

  @override
  String get dmMuteFor24Hours => 'За 24 часа';

  @override
  String get dmMuteFor3Days => 'За 3 дни';

  @override
  String get dmMuteForever => 'Докато не го включа отново';

  @override
  String get dmPinGroupDm => 'Закачи групов личен разговор';

  @override
  String get dmUnpinGroupDm => 'Открепи групов личен разговор';

  @override
  String get dmUnnamedGroup => 'Група без име';

  @override
  String dmOwnersGroup(String resolvedName) {
    return 'Групата на $resolvedName';
  }

  @override
  String get dmFavoriteDm => 'Любим чат';

  @override
  String get dmUnfavoriteDm => 'Премахване от любими';

  @override
  String get dmFavoriteGroupDm => 'Запази групов DM';

  @override
  String get dmUnfavoriteGroupDm => 'Премахни от любими групов личен чат';

  @override
  String get dmChangeFriendNickname => 'Промени прякор на приятел';

  @override
  String get dmRemoveFriend => 'Премахни приятел';

  @override
  String get dmAddFriend => 'Добави приятел';

  @override
  String get dmAcceptFriendRequest => 'Приеми заявка за приятелство';

  @override
  String get dmIgnoreFriendRequest => 'Игнорирай заявката за приятелство';

  @override
  String get dmFriendRequestSent => 'Изпратена заявка за приятелство';

  @override
  String get dmUnblock => 'Отблокиране';

  @override
  String get dmDebugUser => 'Отстраняване на грешки в потребителя';

  @override
  String get dmDebugChannel => 'Отстраняване на грешки в канала';

  @override
  String get dmDebugCategory => 'Отстраняване на грешки в категория';

  @override
  String get dmPinned => 'Закачен чат';

  @override
  String get dmUnpinned => 'Разкачен чат';

  @override
  String get dmMuted => 'Заглушен ЛС';

  @override
  String get dmUnmuted => 'DM е вече без звук';

  @override
  String get dmRemoveFriendConfirmTitle => 'Премахни приятел';

  @override
  String dmRemoveFriendConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да премахнете $username като приятел?';
  }

  @override
  String get dmBlockConfirmTitle => 'Блокиране на потребител';

  @override
  String dmBlockConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да блокирате $username? Те няма да могат да ви пишат или да ви изпращат заявки за приятелство.';
  }

  @override
  String get dmFriendRequestSentToast => 'Покана за приятелство изпратена';

  @override
  String get dmAddFriends => 'Добавяне на приятели';

  @override
  String get addFriendSheetTitle => 'Изпращане на покана за приятелство';

  @override
  String get addFriendUsernameHint => 'Потребителско име#0000';

  @override
  String get addFriendUsernameLabel => 'Потребителско име на приятел';

  @override
  String get addFriendSendRequest => 'Изпращане на покана';

  @override
  String get addFriendNoUserFound =>
      'Няма потребител с това потребителско име.';

  @override
  String get addFriendInvalidUsername =>
      'Въведете валидно потребителско име (Потребителско име#0000).';

  @override
  String get addFriendOutgoingSuccess => 'Покана за приятелство изпратена';

  @override
  String get addFriendClaimTitle => 'Заяви акаунта си';

  @override
  String get addFriendClaimDescription =>
      'За да изпращате покани за приятелство, заявете профила си.';

  @override
  String get addFriendVerifyTitle => 'Потвърдете имейла си';

  @override
  String get addFriendVerifyDescription =>
      'Трябва да потвърдиш имейл адреса си, преди да можеш да изпращаш покани за приятелство.';

  @override
  String get addFriendVerifyEmail => 'Потвърдете имейл';

  @override
  String addFriendIncomingRequests(int count) {
    return 'Входящи заявки за приятелство ($count)';
  }

  @override
  String addFriendOutgoingRequests(int count) {
    return 'Изходящи заявки за приятелство ($count)';
  }

  @override
  String get addFriendIncomingStatus => 'Входяща покана за приятелство';

  @override
  String get addFriendOutgoingStatus => 'Покана за приятелство изпратена';

  @override
  String get addFriendViewProfile => 'Преглед на профил';

  @override
  String get addFriendAccept => 'Приемане';

  @override
  String get addFriendIgnore => 'Игнориране';

  @override
  String get addFriendAcceptTitle => 'Приемане на покана за приятелство';

  @override
  String get addFriendIgnoreTitle => 'Игнориране на покана за приятелство';

  @override
  String addFriendAcceptConfirmDescription(String userName) {
    return 'Приемане на поканата за приятелство от $userName?';
  }

  @override
  String addFriendIgnoreConfirmDescription(String displayName) {
    return 'Игнориране на поканата за приятелство от $displayName?';
  }

  @override
  String get addFriendCancelRequest => 'Отказ на поканата';

  @override
  String get addFriendCancelRequestFailed =>
      'Поканата за приятелство не можа да бъде отменена. Опитайте отново.';

  @override
  String get addFriendNotAcceptingRequests =>
      'В момента не приемат покани за приятелство.';

  @override
  String get addFriendUnblockFirst =>
      'Първо ги отблокирайте, за да изпратите покана за приятелство.';

  @override
  String get addFriendCannotSendToSelf =>
      'Не можеш да си изпратиш покана за приятелство.';

  @override
  String get addFriendAlreadyFriends => 'Вече сте приятели с този потребител.';

  @override
  String get addFriendClaimToSend =>
      'Завършете регистрацията, за да изпращате покани за приятелство.';

  @override
  String get addFriendVerifyToSend =>
      'Потвърдете имейла си, преди да изпращате покани за приятелство.';

  @override
  String get addFriendFriendsListFull =>
      'Списъкът ви с приятели е пълен или техният е. Премахнете някого и опитайте отново.';

  @override
  String get addFriendSendFailedTitle =>
      'Поканата за приятелство не можа да бъде изпратена';

  @override
  String get addFriendSendFailedMessage =>
      'Поканата за приятелство не можа да бъде изпратена. Опитай отново.';

  @override
  String get userTagBot => 'БОТ';

  @override
  String get userTagSystem => 'Система';

  @override
  String get userTagOp => 'OP';

  @override
  String get emojiSearchPlaceholder => 'Намери емоджито на мечтите си';

  @override
  String get emojiSearchEmpty =>
      'Няма емоджита, които да отговарят на търсенето ви';

  @override
  String get emojiAutocompleteDefaultLabel => 'Емоджи по подразбиране';

  @override
  String emojiInfoDefaultDescription(String productName) {
    return 'Това е емоджи по подразбиране във $productName.';
  }

  @override
  String get emojiInfoCustomGuildDescription =>
      'Това емоджи е от тази общност. Можете да го използвате навсякъде.';

  @override
  String get emojiInfoCustomUnknownDescription =>
      'Това е персонализирано емоджи от общност.';

  @override
  String get emojiInfoCustomInviteRequiredDescription =>
      'Това е персонализирано емоджи от общност. Помолете автора за покана, за да използвате това емоджи.';

  @override
  String get emojiInfoFromHeader => 'Това емоджи е от';

  @override
  String get emojiInfoDiscoverableCommunity => 'Включена в „Разглеждане“';

  @override
  String get emojiInfoPrivateCommunity => 'Частна общност';

  @override
  String get emojiInfoVerifiedCommunity => 'Потвърдена общност';

  @override
  String get emojiInfoAddToFavorites => 'Добави към любими';

  @override
  String get emojiInfoRemoveFromFavorites => 'Премахни от любими';

  @override
  String get emojiFrequentlyUsed => 'Често използвани';

  @override
  String get emojiTabGifs => 'GIF-ове';

  @override
  String get emojiTabMedia => 'Медия';

  @override
  String get emojiTabStickers => 'Стикери';

  @override
  String get emojiTabEmojis => 'Емоджита';

  @override
  String get gifPickerSearch => 'Търсене на GIF файлове';

  @override
  String get gifPickerSearchKlipy => 'Търсене в Klipy';

  @override
  String get gifPickerSearchTenor => 'Търсене в Tenor';

  @override
  String get gifPickerFavorites => 'Любими';

  @override
  String get gifPickerFavoritesEmptyTitle => 'Все още няма любими GIF файлове';

  @override
  String get gifPickerFavoritesEmptyDescription =>
      'Отбележете GIF със звезда, за да го видите тук.';

  @override
  String get gifPickerTrending => 'Популярни GIF файлове';

  @override
  String get gifPickerNoResultsTitle => 'Няма резултати от търсенето';

  @override
  String get gifPickerNoResultsDescription => 'Опитай с друг термин за търсене';

  @override
  String get gifPickerLoadFailedTitle => 'Не успяхме да заредим GIF файлове';

  @override
  String get gifPickerLoadFailedBody =>
      'Проверете връзката си и опитайте отново.';

  @override
  String get emojiCategoryPeople => 'Хора';

  @override
  String get emojiCategoryNature => 'Природа';

  @override
  String get emojiCategoryFood => 'Храна и напитки';

  @override
  String get emojiCategoryActivity => 'Дейности';

  @override
  String get emojiCategoryTravel => 'Пътуване и места';

  @override
  String get emojiCategoryObjects => 'Обекти';

  @override
  String get emojiCategorySymbols => 'Символи';

  @override
  String get emojiCategoryFlags => 'Знамена';

  @override
  String emojiPlutoniumUpsellText(String emojiCount, String communityCount) {
    return 'Отключи $emojiCount от $communityCount с Reverb.';
  }

  @override
  String get emojiPlutoniumUpsellDismiss => 'Не показвай отново';

  @override
  String emojiPlutoniumUpsellCustomEmoji(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count персонализирани емоджита',
      one: '1 персонализирано емоджи',
    );
    return '$_temp0';
  }

  @override
  String emojiPlutoniumUpsellCommunity(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count общности',
      one: '1 общност',
    );
    return '$_temp0';
  }

  @override
  String get externalLinkWarningTitle => 'Предупреждение за външна връзка';

  @override
  String externalLinkWarningLeaving(String productName) {
    return 'Предстои да напуснете $productName';
  }

  @override
  String get externalLinkWarningDescription =>
      'Външните връзки могат да бъдат опасни. Моля, бъдете внимателни.';

  @override
  String get externalLinkWarningDestinationUrl => 'Целеви URL адрес:';

  @override
  String get externalLinksSectionTitle => 'Външни връзки';

  @override
  String get externalLinksSectionDescription =>
      'Конфигуриране как се обработват предупрежденията за външни връзки.';

  @override
  String get externalLinkWarningTrustPrefix => 'Винаги се доверявай ';

  @override
  String get externalLinkWarningTrustSuffix =>
      ' — пропусни това предупреждение следващия път';

  @override
  String get externalLinkVisitSite => 'Посети сайта';

  @override
  String get externalLinkTrustAllLabel => 'Доверяване на всички външни връзки';

  @override
  String get externalLinkStripTrackingLabel =>
      'Премахване на параметри за проследяване от URL адреси';

  @override
  String get externalLinkStripTrackingDescription =>
      'Автоматично премахване на параметри за проследяване (като utm_source, fbclid, gclid) от URL адреси в съобщения, които изпращате. Изчиства връзката, преди да достигне до някой друг.';

  @override
  String get externalLinkTrustAllConfirmTitle =>
      'Доверявате ли на всички външни връзки?';

  @override
  String get externalLinkTrustAllConfirmDescription =>
      'Това ще направи всички външни връзки надеждни и ще пропуска предупреждението за всеки домейн. Съществуващите ви надеждни домейни ще бъдат заменени. Това е по-малко сигурно.';

  @override
  String get externalLinkTrustAllConfirmAction => 'Довери се на всички';

  @override
  String get externalLinkStopTrustingAllTitle =>
      'Да спрете да се доверявате на всички връзки?';

  @override
  String get externalLinkStopTrustingAllDescription =>
      'Предупрежденията за външни връзки ще се показват отново. Ще трябва да добавите надеждни домейни поотделно.';

  @override
  String get externalLinkStopTrustingAllAction => 'Забрани доверието на всички';

  @override
  String get externalLinkTrustedAllDescription =>
      'Всички външни връзки са надеждни. Няма да се показват предупреждения.';

  @override
  String externalLinkTrustedDomainsDescription(int count) {
    return 'Имате $count доверен(и) домейн(а). Добавете още, като отметнете квадратчето при посещение на външни връзки.';
  }

  @override
  String get externalLinkTrustAllDisabledDescription =>
      'Когато е активирано, няма да се показват предупреждения за външни връзки. Това е по-малко сигурно.';

  @override
  String get imageFileTooLarge =>
      'Файлът с изображение е твърде голям. Моля, изберете файл, по-малък от 10 MB.';

  @override
  String get animatedAvatarsRequirePlutonium =>
      'Анимираните аватари изискват Reverb';

  @override
  String get animatedBannersRequirePlutonium =>
      'Анимираните банери изискват Reverb';

  @override
  String get animatedAvifNotSupported => 'Анимиран AVIF не се поддържа';

  @override
  String get animatedAvifNotSupportedBody =>
      'Изрязването и завъртането на анимирани AVIF файлове все още не се поддържа. Ако продължите, файлът ще бъде качен в оригиналния си вид.';

  @override
  String get uploadAsIs => 'Качи без промени';

  @override
  String get croppingAnimatedNotSupported =>
      'Анимирани изображения не могат да бъдат изрязвани. Ще бъде използвано оригиналното изображение.';

  @override
  String get cropAvatar => 'Изрежи аватар';

  @override
  String get cropBanner => 'Изрязване на банер';

  @override
  String get skip => 'Пропусни';

  @override
  String get crop => 'Изрежи';

  @override
  String get cropTouchHint =>
      'Прищипете, за да увеличите, плъзнете, за да преместите';

  @override
  String get cropMouseHint =>
      'Плъзнете ъглите, за да промените размера, плъзнете вътре, за да преместите';

  @override
  String get changeYourFluxerTag => 'Промяна на потребителско име';

  @override
  String get fluxerTagDescriptionBase =>
      'Потребителските имена могат да съдържат само букви (a-z, A-Z), цифри (0-9) и долни черти. В потребителските имена не се прави разлика между главни и малки букви.';

  @override
  String get fluxerTagDescriptionVisionary =>
      'Потребителските имена могат да съдържат само букви (a-z, A-Z), цифри (0-9) и долни черти. Потребителските имена не правят разлика между малки и главни букви. Можете да изберете всеки наличен 4-цифрен таг от #0000 до #9999.';

  @override
  String get fluxerTagDescriptionPremium =>
      'Потребителските имена могат да съдържат само букви (a-z, A-Z), цифри (0-9) и долни черти. Потребителските имена не правят разлика между главни и малки букви. Можете да изберете всяка налична 4-цифрена таг от #0001 до #9999.';

  @override
  String validationLengthRange(int min, int max) {
    return 'Между $min и $max знака';
  }

  @override
  String get validationAllowedChars =>
      'Само букви (a-z, A-Z), цифри (0-9) и долни черти (_)';

  @override
  String get fluxerTagAlreadyTaken => 'Потребителското име вече е заето';

  @override
  String fluxerTagAlreadyTakenBody(String username, String discriminator) {
    return 'Потребителското име $username#$discriminator вече е заето. Продължаването ще преизбере автоматично вашия дискриминатор.';
  }

  @override
  String get customTagIsTemporary => 'Персонализираният етикет е временен';

  @override
  String customTagTemporaryBodyWithDate(String date) {
    return 'Вашият персонализиран 4-цифрен таг е наличен само докато абонаментът ви за Reverb е активен. Когато абонаментът ви изтече на $date, тагът ви ще се върне към случайно присвоен номер след 3-дневен гратисен период.';
  }

  @override
  String get customTagTemporaryBody =>
      'Вашият персонализиран 4-цифрен таг е наличен само докато абонаментът ви за Reverb е активен. Когато абонаментът ви изтече, тагът ви ще се върне към случайно присвоен номер след 3-дневен гратисен период.';

  @override
  String get iUnderstandContinue => 'Разбирам, продължи';

  @override
  String get premiumWarningPendingDiscriminator =>
      'Ако запазите това потребителско име, вашият персонализиран 4-цифрен таг ще се върне към случайно число, когато абонаментът ви за Reverb приключи. Ако абонаментът ви не бъде подновен, ще имате 3-дневен гратисен период, преди тагът да се промени.';

  @override
  String premiumWarningActiveDiscriminator(String discriminator) {
    return 'Вашият персонализиран 4-цифрен таг (#$discriminator) е активен, докато абонаментът ви за Reverb е активен. Ако абонаментът ви приключи или не бъде подновен след 3-дневен гратисен период, тагът ви ще се върне към произволен номер.';
  }

  @override
  String get premiumUpsellCustomizeTag =>
      'Персонализирайте своя 4-цифрен таг или го запазете при смяна на потребителското си име';

  @override
  String get fluxerTagUpdated => 'Потребителското име е актуализирано';

  @override
  String get fluxerTagUpdateFailed =>
      'Неуспешно обновяване на потребителското име. Моля, опитайте отново.';

  @override
  String get continueAction => 'Продължи';

  @override
  String get profileCustomizationTitle => 'Персонализиране на профила';

  @override
  String get profileCustomizationDescription =>
      'Редактирайте изгледа на профила си и вижте предварителен преглед на живо';

  @override
  String get usernameLabel => 'Потребителско име';

  @override
  String get claimAccountToChangeFluxerTag =>
      'Заявете профила си, за да промените потребителското си име';

  @override
  String get changeFluxerTag => 'Промяна на потребителско име';

  @override
  String customizeTagWithPlutoniumTooltip(String discriminator) {
    return 'Персонализирайте своя 4-цифрен таг (#$discriminator) по ваш вкус с Reverb';
  }

  @override
  String get changeUsernameAndTagHint =>
      'Промени потребителското си име и 4-цифрен етикет';

  @override
  String customTagSubscriptionWarning(String discriminator) {
    return 'Вашият персонализиран таг (#$discriminator) е свързан с вашия Reverb абонамент и ще се върне към случаен таг, ако изтече.';
  }

  @override
  String get displayNameLabel => 'Име за показване';

  @override
  String get pronounsLabel => 'Местоимения';

  @override
  String get avatarLabel => 'Аватар';

  @override
  String get changeAvatar => 'Промени аватара';

  @override
  String get removeAvatar => 'Премахни аватара';

  @override
  String get avatarDescription =>
      'PNG, JPEG, WebP, GIF. Макс. 10 MB. Препоръчително: 512×512px';

  @override
  String get bannerLabel => 'Банер';

  @override
  String get changeBanner => 'Промени банер';

  @override
  String get removeBanner => 'Премахни банера';

  @override
  String get bannerDescription =>
      'PNG, JPEG, WebP, GIF. Макс. 10MB. Минимум: 960×540px (16:9)';

  @override
  String get accentColorLabel => 'Цвят на акцента';

  @override
  String get accentColorDescription =>
      'Персонализира цвета на рамката и банера в профила ви';

  @override
  String get aboutMeLabel => 'За мен';

  @override
  String get aboutMeHelperText =>
      'Можете да използвате връзки, емоджита и Markdown.';

  @override
  String get emojiPickerTitle => 'Емотикони';

  @override
  String get profileBadgesSettingsTitle => 'Badges';

  @override
  String get profileBadgesSettingsDescription =>
      'Choose which badges other people see on your profile.';

  @override
  String get profileBadgesSettingsEmpty => 'You don\'t have any badges yet.';

  @override
  String get profileBadgesSettingsLoadFailed =>
      'Your badges couldn\'t be loaded.';

  @override
  String profileBadgesShowOnProfile(String badgeLabel) {
    return 'Show $badgeLabel on your profile';
  }

  @override
  String get profileBadgesVisionaryNumberNote =>
      'Shown only when your Visionary badge is visible and not masked.';

  @override
  String get plutoniumBadgePrivacyTitle => 'Поверителност на значката Reverb';

  @override
  String get plutoniumBadgePrivacyDescription =>
      'Контролирайте как се показва вашият Reverb значка на другите';

  @override
  String get hidePlutoniumBadgeLabel => 'Скрий напълно значката Reverb';

  @override
  String get hidePlutoniumBadgeDescription =>
      'Напълно скрийте значката си Reverb от други потребители';

  @override
  String get hidePlutoniumPurchaseDate => 'Скрий датата на покупка на Reverb';

  @override
  String hidePlutoniumPurchaseDateWithDate(String date) {
    return 'Скрий датата на покупка на Reverb ($date)';
  }

  @override
  String get hidePurchaseDateDescription =>
      'Премахни кога за първи път си купил Reverb от значката си';

  @override
  String get maskVisionaryAsSubscription => 'Скрий Visionary като абонамент';

  @override
  String get maskVisionaryDescription =>
      'Показване на Visionary като редовен абонамент';

  @override
  String get hideVisionaryIdBadge => 'Скрий значката \"Визионерски ИД\"';

  @override
  String hideVisionaryIdBadgeWithSequence(int sequence) {
    return 'Скрий значката Visionary ID (#$sequence)';
  }

  @override
  String get hideVisionaryIdDescription =>
      'Премахване на значката за Visionary ID';

  @override
  String get operatorPassName => 'Operator Pass';

  @override
  String operatorPassSince(String since) {
    return 'Operator Pass since $since';
  }

  @override
  String get operatorPassShowBadgeOnProfile => 'Show badge on my profile';

  @override
  String operatorPassHideDate(String operatorPassName) {
    return 'Hide when you got your $operatorPassName';
  }

  @override
  String get operatorPassHideCount => 'Hide how many Operator Passes you have';

  @override
  String get operatorPassWallTitle => 'Operators\' wall';

  @override
  String get operatorPassWallHowItWorks => 'How the wall works';

  @override
  String get operatorPassWallNotListed => 'Not listed.';

  @override
  String get operatorPassWallOnTheWall => 'On the wall';

  @override
  String get operatorPassWallInReview => 'In review';

  @override
  String operatorPassWallReviewBy(String date) {
    return 'by $date';
  }

  @override
  String get operatorPassWallLive => 'Live';

  @override
  String operatorPassWallDeclined(String name, String reason) {
    return 'Declined: $name. $reason.';
  }

  @override
  String operatorPassWallTeamNote(String note) {
    return 'Team note: $note';
  }

  @override
  String get operatorPassWallHidden => 'Hidden by our team for now.';

  @override
  String get operatorPassWallHiddenWhy => 'Why?';

  @override
  String get operatorPassWallRemoved =>
      'Off the wall while your benefits are removed.';

  @override
  String get operatorPassTermsLink => 'Operator Pass terms';

  @override
  String get operatorPassWallSendChanges => 'Send profile changes to the wall';

  @override
  String get operatorPassWallReleaseList =>
      'Add my name to the yearly Operators list';

  @override
  String get operatorPassWallReleaseListHint =>
      'Once a year, we publish a list of Operators in the notes of an echowire release and in its source code. Your wall name is only on it if you turn this on.';

  @override
  String get operatorPassWallSave => 'Save';

  @override
  String get operatorPassWallSaved => 'Saved.';

  @override
  String get operatorPassWallSaveFailed => 'Couldn\'t save. Try again.';

  @override
  String get operatorPassWallNameSettingsLabel => 'Name on the wall';

  @override
  String get operatorPassWallNameHint =>
      'We check new names before they go live.';

  @override
  String get operatorPassWallDontListMe => 'Don\'t list me';

  @override
  String get operatorPassWallNameRequired =>
      'Enter a name, or check Don\'t list me.';

  @override
  String get operatorPassWallNameTooLong => 'Use 32 characters or fewer.';

  @override
  String get operatorPassWallDeclineGuidelines =>
      'Breaks the community guidelines';

  @override
  String get operatorPassWallDeclineImpersonation =>
      'Pretends to be someone else';

  @override
  String get operatorPassWallDeclineRights =>
      'Uses a name or image without the rights to it';

  @override
  String get operatorPassWallDeclineAge => 'Not suitable for younger users';

  @override
  String get avatarDescriptionNonPremium =>
      'JPEG, PNG, WebP. Максимум 10 MB. Препоръчително: 512×512 px. Анимирани аватари (GIF) изискват Reverb.';

  @override
  String get bannerPlutoniumUpsell =>
      'Персонализирайте профила си със статично или анимирано банер изображение, за да го отличите.';

  @override
  String get getPlutonium => 'Вземи Reverb';

  @override
  String get plutoniumNotAvailableTitle => 'Reverb';

  @override
  String get plutoniumNotAvailableBody =>
      'Покупки в приложението все още не са налични на тази платформа. Следете ни — скоро ще бъдат налични!';

  @override
  String get profilePreviewLabel => 'Преглед';

  @override
  String get profilePreviewMessage => 'Изпрати съобщение';

  @override
  String profilePreviewMemberSince(String productName) {
    return 'Член на $productName от';
  }

  @override
  String get unclaimedAccountTitle => 'Непотърсена сметка';

  @override
  String get unclaimedAccountDescription =>
      'Вашият акаунт все още не е заявен. Без имейл и парола може да загубите достъп. Заявете акаунта си сега, за да го защитите.';

  @override
  String get claimAccount => 'Заяви акаунт';

  @override
  String get profileTypeLabel => 'Тип профил';

  @override
  String get profileTypeGlobal => 'Глобален профил';

  @override
  String get profileTypeGuildDescription =>
      'Редактирате профила си за тази общност. Той ще бъде видим само в нея и ще замени глобалния ви профил.';

  @override
  String get communityNicknameLabel => 'Прякор в общността';

  @override
  String get perGuildPremiumUpsellText =>
      'Персонализирането на вашия аватар, банер, цвят на акцента и биография за отделни общности изисква Reverb. Прякорът и местоименията в общността са безплатни за всички.';

  @override
  String get avatarModeInherit => 'Използвай глобален профил';

  @override
  String get avatarModeCustom => 'Използвай персонализирано изображение';

  @override
  String get avatarModeUnset => 'Не показвай';

  @override
  String get profileSavedToast => 'Профилът е актуализиран';

  @override
  String get sudoTitle => 'Потвърдете самоличността си';

  @override
  String get sudoDescription => 'За да продължите, е необходимо потвърждение.';

  @override
  String get sudoAuthenticatorCode => 'Код на удостоверяване';

  @override
  String get sudoMethodPassword => 'Парола';

  @override
  String get sudoMethodTotp => 'Удостоверяване';

  @override
  String get sudoVerificationFailed =>
      'Проверката не успя. Моля, опитайте отново.';

  @override
  String get securityAccountTitle => 'Профил';

  @override
  String get securityAccountDescription =>
      'Управлявайте имейла, паролата и настройките на акаунта си';

  @override
  String get securitySectionTitle => 'Сигурност';

  @override
  String get securitySectionDescription =>
      'Защитете акаунта си с двуфакторна автентикация и passkeys';

  @override
  String get securityLoginEmailSectionTitle => 'Имейл настройки';

  @override
  String securityLoginEmailSectionDescription(String productName) {
    return 'Управлявайте имейл адреса, който използвате за влизане в $productName';
  }

  @override
  String get securityLoginEmailAddressLabel => 'Имейл адрес';

  @override
  String get securityLoginNoEmailSet => 'Няма зададен имейл адрес';

  @override
  String get securityLoginChangeEmail => 'Промяна на имейл';

  @override
  String get securityLoginAddEmail => 'Добавяне на имейл';

  @override
  String get securityLoginReveal => 'Покажи';

  @override
  String get securityLoginHide => 'Скрий';

  @override
  String get securityLoginPasswordSectionTitle => 'Парола';

  @override
  String get securityLoginPasswordSectionDescription =>
      'Променете паролата си, за да поддържате акаунта си защитен';

  @override
  String get securityLoginCurrentPasswordLabel => 'Текуща парола';

  @override
  String securityLoginPasswordLastChanged(String date) {
    return 'Последно сменена: $date';
  }

  @override
  String get securityLoginPasswordNeverChanged => 'Последна промяна: Никога';

  @override
  String get securityLoginNoPasswordSet => 'Няма зададена парола';

  @override
  String get securityLoginChangePassword => 'Смяна на паролата';

  @override
  String get securityLoginSetPassword => 'Задай парола';

  @override
  String get passwordChangeTitle => 'Смяна на парола';

  @override
  String get passwordChangeIntroDescription =>
      'Ще изпратим код за потвърждение на имейл адреса ви, за да потвърдим самоличността ви, преди да сменим паролата.';

  @override
  String get passwordChangeStart => 'Начало';

  @override
  String get passwordChangeVerifyTitle => 'Потвърдете имейла си';

  @override
  String get passwordChangeVerifyDescription =>
      'Въведете кода за потвърждение, изпратен на вашия имейл адрес.';

  @override
  String get passwordChangeVerificationCode => 'Код за потвърждение';

  @override
  String get passwordChangeVerify => 'Потвърди';

  @override
  String get passwordChangeNewPasswordTitle => 'Задай нова парола';

  @override
  String get passwordChangeNewPasswordDescription =>
      'Въведете новата си парола по-долу.';

  @override
  String get passwordChangeNewPassword => 'Нова парола';

  @override
  String get passwordChangeConfirmPassword => 'Потвърди нова парола';

  @override
  String get passwordChangeSubmit => 'Смяна на паролата';

  @override
  String get passwordChangeSuccess => 'Паролата е сменена';

  @override
  String get passwordChangePasswordsDoNotMatch => 'Паролите не съвпадат';

  @override
  String get passwordChangeInvalidCode => 'Невалиден или изтекъл код';

  @override
  String get emailChangeTitle => 'Промяна на имейл';

  @override
  String get emailChangeIntroDescription =>
      'Ще изпратим кодове за потвърждение, за да проверим самоличността ви, преди да променим имейл адреса ви.';

  @override
  String get emailChangeStart => 'Начало';

  @override
  String get emailChangeVerifyOriginalTitle => 'Потвърди текущия имейл';

  @override
  String get emailChangeVerifyOriginalDescription =>
      'Въведете кода за потвърждение, изпратен на текущия ви имейл адрес.';

  @override
  String get emailChangeNewEmailTitle => 'Въведете нов имейл';

  @override
  String get emailChangeNewEmailDescription =>
      'Въведете новия имейл адрес, който искате да използвате.';

  @override
  String get emailChangeNewEmailLabel => 'Нов имейл';

  @override
  String get emailChangeNewEmailSubmit => 'Изпрати код за потвърждение';

  @override
  String get emailChangeVerifyNewTitle => 'Потвърди нов имейл';

  @override
  String get emailChangeVerifyNewDescription =>
      'Въведете кода за потвърждение, изпратен на новия ви имейл адрес.';

  @override
  String get emailChangeSuccess => 'Имейлът е променен';

  @override
  String get emailChangeInvalidCode => 'Невалиден или изтекъл код';

  @override
  String get resend => 'Изпрати отново';

  @override
  String resendCountdown(int seconds) {
    return 'Препрати ($seconds сек.)';
  }

  @override
  String get verificationCode => 'Код за потвърждение';

  @override
  String get verify => 'Потвърди';

  @override
  String get enable => 'Активиране';

  @override
  String get disable => 'Изключване';

  @override
  String get delete => 'Изтриване';

  @override
  String get save => 'Запазване';

  @override
  String get securityTfaSectionTitle => 'Двуфакторна автентикация';

  @override
  String get securityTfaSectionDescription =>
      'Добавете допълнителен слой сигурност към профила си';

  @override
  String get securityTfaAuthenticatorApp => 'Приложение за удостоверяване';

  @override
  String get securityTfaAuthenticatorEnabled =>
      'Двуфакторното удостоверяване е включено';

  @override
  String get securityTfaAuthenticatorDisabled =>
      'Използвайте приложение за удостоверяване, за да генерирате кодове за двуфакторно удостоверяване';

  @override
  String get securityTfaBackupCodes => 'Резервни кодове';

  @override
  String get securityTfaBackupCodesDescription =>
      'Преглед и управление на кодовете за възстановяване на акаунт';

  @override
  String get securityTfaViewCodes => 'Преглед на кодове';

  @override
  String get securityPasskeysSectionTitle => 'Ключове за достъп';

  @override
  String get securityPasskeysSectionDescription =>
      'Използвайте ключове за вход без парола и двуфакторно удостоверяване';

  @override
  String get securityPasskeysRegistered => 'Регистрирани пароли';

  @override
  String get securityPasskeysNone => 'Няма регистрирани пароли';

  @override
  String securityPasskeysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'пароли',
      one: 'парола',
    );
    return '$count $_temp0 регистрирани (макс. 10)';
  }

  @override
  String get securityPasskeysAdd => 'Добавяне на ключ за достъп';

  @override
  String securityPasskeysAdded(String date) {
    return 'Добавено: $date';
  }

  @override
  String securityPasskeysLastUsed(String date) {
    return 'Последно използван: $date';
  }

  @override
  String get securityPasskeysRename => 'Преименуване';

  @override
  String get securityPasskeysDeleteTitle => 'Изтриване на ключ за достъп';

  @override
  String securityPasskeysDeleteDescription(String name) {
    return 'Сигурни ли сте, че искате да изтриете пропусключа $name?';
  }

  @override
  String get securityPasskeyNameTitle => 'Име на пропуск код';

  @override
  String get securityPasskeyNameLabel => 'Име на пропуск код';

  @override
  String get securityPasskeyNameHint =>
      'напр. YubiKey, iPhone, Работен компютър';

  @override
  String get securityClaimTitle => 'Функции за сигурност';

  @override
  String get securityClaimDescription =>
      'Заявете профила си, за да получите достъп до функции за сигурност като двуфакторно удостоверяване и ключове за достъп.';

  @override
  String get securityVerifyEmailRequired =>
      'Трябва да потвърдите имейл адреса си, преди да можете да настроите двуфакторна автентикация или пропуск ключове.';

  @override
  String get totpEnableTitle => 'Настройване на приложение за удостоверяване';

  @override
  String get totpEnableDescription =>
      'Сканирайте QR кода с приложението си за удостоверяване, за да генерирате кодове за двуфакторна автентикация.';

  @override
  String get totpEnableCodeLabel => 'Код';

  @override
  String get totpEnableCodeHint =>
      'Въведете 6-цифрения код от приложението си за удостоверяване';

  @override
  String get totpEnableSuccess => 'Двуфакторното удостоверяване е активирано';

  @override
  String get totpDisableTitle => 'Премахване на приложение за удостоверяване';

  @override
  String get totpDisableDescription =>
      'Въведете 6-цифрения код от приложението си за удостоверяване, за да деактивирате двуфакторното удостоверяване.';

  @override
  String get totpDisableSuccess =>
      'Двуфакторното удостоверяване е деактивирано';

  @override
  String get backupCodesTitle => 'Резервни кодове';

  @override
  String get backupCodesWarning =>
      'Ако загубите достъп до приложението си за удостоверяване и нямате тези кодове, ще бъдете завинаги заключени от профила си. Изтеглете ги или ги копирайте сега и ги съхранявайте на сигурно място.';

  @override
  String get backupCodesCopy => 'Копирай';

  @override
  String get backupCodesCopied => 'Резервните кодове са копирани в клипборда';

  @override
  String get backupCodesAcknowledge =>
      'Изтеглих или копирах моите резервни кодове и ги съхраних на сигурно място.';

  @override
  String get backupCodesDone => 'Готово';

  @override
  String get dangerZoneSectionTitle => 'Зона за опасни действия';

  @override
  String get dangerZoneSectionDescription =>
      'Необратими и разрушителни действия';

  @override
  String get dangerZoneDisableTitle => 'Деактивиране на акаунта';

  @override
  String get dangerZoneDisableDescription =>
      'Временно деактивирайте профила си. Можете да го активирате отново по-късно, като влезете пак.';

  @override
  String get dangerZoneDisableConfirmDescription =>
      'Деактивирането на акаунта ви ще ви отпише от всички сесии. Можете да активирате акаунта си отново по всяко време, като влезете отново.';

  @override
  String get dangerZoneDeleteTitle => 'Изтриване на акаунт';

  @override
  String get dangerZoneDeleteDescription =>
      'Изтрийте завинаги профила си и всички свързани данни. Това действие не може да бъде отменено.';

  @override
  String get dangerZoneDeleteCannotDeleteAccount =>
      'Не може да се изтрие акаунтът';

  @override
  String get dangerZoneDeleteOwnsCommunities =>
      'Не можете да изтриете акаунта си, докато притежавате общности. Първо прехвърлете собствеността на следните общности:';

  @override
  String dangerZoneDeleteAndXMore(int count) {
    return 'и още $count';
  }

  @override
  String dangerZoneDeleteTransferInstructions(String settingsPath) {
    return 'За да прехвърлите собствеността, отидете на $settingsPath и използвайте опцията за прехвърляне на собствеността.';
  }

  @override
  String get dangerZoneDeleteConfirmDescription =>
      'Сигурни ли сте, че искате да изтриете профила си? Това действие ще насрочи профила ви за окончателно изтриване.';

  @override
  String get dangerZoneDeleteBullet1 =>
      'Можеш да отмениш процеса по изтриване до 14 дни';

  @override
  String get dangerZoneDeleteBullet2 =>
      'След 14 дни акаунтът ви ще бъде изтрит завинаги';

  @override
  String get dangerZoneDeleteBullet3 =>
      'След като изтриването приключи, няма да имате достъп до акаунта си';

  @override
  String get dangerZoneDeleteBullet4 =>
      'Няма да можете да изтриете изпратените си съобщения, след като акаунтът ви бъде изтрит';

  @override
  String get dangerZoneDeleteDisclaimer =>
      'Ако искате да експортирате данните си или да изтриете съобщенията си първо, моля, посетете секцията „Табло за поверителност“ в Настройките на потребителя, преди да продължите.';

  @override
  String get claimAccountTitle => 'Заяви своя акаунт';

  @override
  String get claimAccountDescription =>
      'Заявете профила си, като добавите имейл и парола. Ще изпратим код за потвърждение на имейла ви, преди да приключите.';

  @override
  String get claimAccountEmailLabel => 'Имейл';

  @override
  String get claimAccountPasswordLabel => 'Парола';

  @override
  String get claimAccountSendCode => 'Изпрати код';

  @override
  String get claimAccountVerifyDescription =>
      'Въведете кода, който изпратихме на имейла ви, за да го потвърдите. Паролата ви ще бъде зададена, след като кодът бъде потвърден.';

  @override
  String get claimAccountSuccess => 'Профилът е заявен успешно';

  @override
  String get importantInformation => 'Важна информация:';

  @override
  String get genericError => 'Възникна грешка';

  @override
  String get networkErrorMessage => 'Нещо се обърка. Моля, опитайте отново.';

  @override
  String get invalidCode => 'Невалиден код';

  @override
  String relativeTimeYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count години',
      one: 'преди 1 година',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count месеца',
      one: 'преди 1 месец',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count дни',
      one: 'преди 1 ден',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count часа',
      one: 'преди 1 час',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count минути',
      one: 'преди 1 минута',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count седмици',
      one: 'преди 1 седмица',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeInMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'след $count минути',
      one: 'след 1 минута',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeInHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'след $count часа',
      one: 'след 1 час',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'след $count дни',
      one: 'след 1 ден',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeInWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'след $count седмици',
      one: 'след 1 седмица',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeInMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'след $count месеца',
      one: 'след 1 месец',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeInYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'след $count години',
      one: 'след 1 година',
    );
    return '$_temp0';
  }

  @override
  String get relativeTimeJustNow => 'току-що';

  @override
  String get authorizedAppsTitle => 'Оторизирани приложения';

  @override
  String authorizedAppsDescription(String productName) {
    return 'Тези приложения имат достъп до вашия акаунт в $productName.';
  }

  @override
  String get authorizedAppsEmptyTitle => 'Няма оторизирани приложения';

  @override
  String get authorizedAppsEmptyDescription =>
      'Все още не сте оторизирали приложения за достъп до акаунта си.';

  @override
  String get authorizedAppsLoadError =>
      'Неуспешно зареждане на оторизирани приложения';

  @override
  String authorizedAppsAuthorizedOn(String date) {
    return 'Упълномощен на $date';
  }

  @override
  String get authorizedAppsPermissionsGranted => 'Разрешения, предоставени';

  @override
  String get authorizedAppsRevoke => 'Отмени';

  @override
  String get authorizedAppsRevokeTitle => 'Отнемане на достъп до приложението';

  @override
  String authorizedAppsRevokeDescription(String appName) {
    return 'Сигурни ли сте, че искате да отмените достъпа за $appName? Това приложение вече няма да има достъп до вашия акаунт.';
  }

  @override
  String get authorizedAppsScopeIdentify =>
      'Достъп до основна информация за профила ви (потребителско име, аватар и др.)';

  @override
  String get authorizedAppsScopeEmail => 'Преглед на имейл адреса';

  @override
  String get authorizedAppsScopeGuilds =>
      'Преглед на общностите, в които членувате';

  @override
  String get authorizedAppsScopeConnections =>
      'Преглед на свързаните ви профили';

  @override
  String get authorizedAppsScopeBot =>
      'Добавяне на бот към общност с искани разрешения';

  @override
  String get authorizedAppsScopeAdmin =>
      'Достъп до административни крайни точки';

  @override
  String get applicationsTitle => 'Приложения';

  @override
  String get applicationsCreate => 'Създаване на приложение';

  @override
  String get applicationsCreateSubmit => 'Създаване';

  @override
  String get applicationsCreateClaimTooltip =>
      'Заяви акаунта си, за да създаваш приложения.';

  @override
  String applicationsDocsLink(String domain) {
    return 'Прочети документацията ($domain)';
  }

  @override
  String get applicationsLoadError => 'Приложенията не могат да бъдат заредени';

  @override
  String get applicationsLoadErrorDescription =>
      'Провери връзката си и опитай отново.';

  @override
  String get applicationsEmptyTitle => 'Все още няма приложения';

  @override
  String applicationsEmptyDescription(String apiName) {
    return 'Създай първото си приложение, за да започнеш с $apiName.';
  }

  @override
  String applicationsCreated(String date) {
    return 'Създадено на $date';
  }

  @override
  String get applicationsName => 'Име на приложението';

  @override
  String get applicationsNameHint => 'Моето приложение';

  @override
  String get applicationsNameRequired => 'Името на приложението е задължително';

  @override
  String get applicationsBackToList => 'Назад към списъка';

  @override
  String get applicationsDetailLoadError =>
      'Приложението не можа да бъде заредено';

  @override
  String get applicationsDetailLoadErrorDescription =>
      'Опитай отново или се върни към списъка с приложения.';

  @override
  String get applicationsId => 'ID на приложението';

  @override
  String get applicationsCopyId => 'Копирай ID';

  @override
  String get applicationsSecretsTitle => 'Тайни и токени';

  @override
  String get applicationsSecretsDescription =>
      'Пази ги на сигурно място. Генерирането на нови ще прекъсне съществуващите интеграции.';

  @override
  String get applicationsClientSecret => 'Клиентска тайна';

  @override
  String get applicationsBotToken => 'Токен на бота';

  @override
  String get applicationsRegenerate => 'Генериране наново';

  @override
  String get applicationsRegenerateClientSecretTitle =>
      'Да се генерира ли нова клиентска тайна?';

  @override
  String get applicationsRegenerateBotTokenTitle =>
      'Да се генерира ли нов токен за бота?';

  @override
  String get applicationsRegenerateClientSecretDescription =>
      'Генерирането на нова тайна ще направи текущата невалидна. Актуализирай всеки код, който използва старата стойност.';

  @override
  String get applicationsRegenerateBotTokenDescription =>
      'Генерирането на нов токен ще направи текущия невалиден. Актуализирай всеки код, който използва старата стойност.';

  @override
  String get applicationsClientSecretRegenerated =>
      'Клиентската тайна е генерирана наново. Актуализирай всеки код, който използва старата тайна.';

  @override
  String get applicationsBotTokenRegenerated =>
      'Токенът на бота е генериран наново. Актуализирай всеки код, който използва стария токен.';

  @override
  String get applicationsRegenerateFailed =>
      'Неуспешно повторно генериране на секретния ключ';

  @override
  String get applicationsInfoTitle => 'Информация за приложението';

  @override
  String get applicationsInfoDescription =>
      'Основни настройки и разрешени URI адреси за пренасочване.';

  @override
  String get applicationsPublicBot => 'Публичен бот';

  @override
  String get applicationsPublicBotDescription =>
      'Позволява на всеки да кани този бот в своите общности.';

  @override
  String get applicationsRequireCodeGrant =>
      'Изискване на предоставяне на OAuth2 код';

  @override
  String get applicationsRequireCodeGrantDescription =>
      'Изисква URI за пренасочване и код за оторизация при покана на този бот.';

  @override
  String get applicationsRedirectUris => 'URI адреси за пренасочване';

  @override
  String get applicationsAddRedirect => 'Добавяне на пренасочване';

  @override
  String get applicationsDeleteRedirect => 'Изтриване на URI за пренасочване';

  @override
  String get applicationsBotProfileTitle => 'Профил на бота';

  @override
  String get applicationsBotProfileDescription =>
      'Аватар, таг и подробен профил за твоя бот.';

  @override
  String get applicationsBotAvatar => 'Аватар на бота';

  @override
  String get applicationsUsernameRequired => 'Изисква се потребителско име';

  @override
  String get applicationsUsernameTooLong =>
      'Потребителското име трябва да е до 32 знака';

  @override
  String get applicationsUsernameInvalid =>
      'Потребителското име може да съдържа само букви, цифри и долни черти';

  @override
  String get applicationsBotUsername => 'Потребителско име на бота';

  @override
  String get applicationsDiscriminator => 'Дискриминатор';

  @override
  String get applicationsBotBio => 'Биография на бота';

  @override
  String get applicationsBotBioHint =>
      'Полезен бот, който прави невероятни неща!';

  @override
  String get applicationsNoBotBanner => 'Няма банер на бота';

  @override
  String get applicationsFriendlyBot => 'Приятелски бот';

  @override
  String get applicationsFriendlyBotDescription =>
      'Позволява на потребителите да изпращат на този бот покани за приятелство, които се одобряват ръчно.';

  @override
  String get applicationsManualFriendApproval =>
      'Изискване на ръчно одобрение за приятелство';

  @override
  String get applicationsManualFriendApprovalDescription =>
      'Поканите за приятелство към този бот изискват ръчно одобрение.';

  @override
  String get applicationsOauthBuilderTitle => 'Конструктор на OAuth2 URL';

  @override
  String get applicationsOauthBuilderDescription =>
      'Създайте URL адрес за оторизация с обхвати и разрешения.';

  @override
  String get applicationsScopes => 'Обхвати';

  @override
  String get applicationsRedirectUri => 'URI за пренасочване';

  @override
  String get applicationsSelectRedirectUri => 'Избери URI за пренасочване';

  @override
  String get applicationsRedirectRequiredCodeGrant =>
      'URI за пренасочване е задължителен, защото този бот изисква предоставяне на OAuth2 код.';

  @override
  String get applicationsRedirectRequiredScopes =>
      'Изисква се URI за пренасочване, когато не се използва само обхватът на бота.';

  @override
  String get applicationsBotPermissions => 'Разрешения за бота';

  @override
  String get applicationsAuthorizeUrl => 'URL за оторизация';

  @override
  String get applicationsAuthorizeUrlPlaceholder =>
      'Избери обхвати (и URI за пренасочване, ако е необходимо)';

  @override
  String get applicationsCopyAuthorizeUrl => 'Копирай URL адреса за оторизация';

  @override
  String get applicationsCopiedUrl => 'URL адресът е копиран в клипборда';

  @override
  String get applicationsDangerTitle => 'Опасна зона';

  @override
  String get applicationsDangerSubtitle =>
      'Това действие не може да бъде отменено. Премахването на приложението изтрива и неговия бот.';

  @override
  String get applicationsDangerHelper =>
      'След изтриване приложението и идентификационните му данни се премахват за постоянно.';

  @override
  String get applicationsDelete => 'Изтриване на приложението';

  @override
  String applicationsDeleteConfirmDescription(String name) {
    return 'Наистина ли искате да изтриете $name? Това действие не може да бъде отменено. Всички свързани данни, включително потребителят на бота, ще бъдат изтрити завинаги.';
  }

  @override
  String get applicationsDeleteFailed => 'Приложението не можа да бъде изтрито';

  @override
  String get applicationsUpdated => 'Приложението е актуализирано успешно';

  @override
  String get applicationsNoChanges => 'Няма промени за запазване';

  @override
  String get applicationsSearchBots => 'Приложения и ботове';

  @override
  String get applicationsSearchBotsDescription =>
      'Създаване и управление на приложения и ботове за акаунта ти';

  @override
  String get applicationsSearchInfoDescription =>
      'Редактиране на основни данни за приложението и URI адреси за пренасочване';

  @override
  String get applicationsSearchBotProfileDescription =>
      'Редактиране на аватара, тага, биографията и банера на бота, както и поведението при покани за приятелство';

  @override
  String get applicationsSearchOauthDescription =>
      'Създаване на URL адрес за оторизация с обхвати, пренасочвания и разрешения за ботове';

  @override
  String get applicationsSearchSecretsDescription =>
      'Преглед и повторно генериране на клиентски тайни и токени на ботове';

  @override
  String get applicationsSearchBotsKeyword => 'Ботове';

  @override
  String get applicationsSearchDocumentation => 'Документация';

  @override
  String get blockedUsersTitle => 'Блокирани потребители';

  @override
  String get blockedUsersDescription =>
      'Блокираните потребители не могат да ви изпращат покани за приятелство или директни съобщения.';

  @override
  String get blockedUsersEmptyTitle => 'Няма блокирани потребители';

  @override
  String get blockedUsersEmptyDescription => 'Все още не сте блокирали никого.';

  @override
  String get blockedUsersLoadError =>
      'Неуспешно зареждане на блокирани потребители';

  @override
  String get blockedUsersUnblock => 'Отблокиране';

  @override
  String get blockedUsersUnblockTitle => 'Отблокиране на потребител';

  @override
  String blockedUsersUnblockDescription(String username) {
    return 'Сигурни ли сте, че искате да премахнете $username от блокираните потребители?';
  }

  @override
  String get blockedUsersCopyTag => 'Копирай потребителско име';

  @override
  String get blockedUsersCopyId => 'Копирай ID на потребител';

  @override
  String get userProfileLoadError => 'Не успяхме да заредим профила';

  @override
  String get userProfileLoading => 'Зареждане на профил';

  @override
  String get userProfileRetry => 'Опитай отново';

  @override
  String get userProfileMessage => 'Изпрати съобщение';

  @override
  String get userProfileVoiceCall => 'Гласово повикване';

  @override
  String get userProfileVideoCall => 'Видео разговор';

  @override
  String get userProfileEditProfile => 'Редактиране на профил';

  @override
  String userProfileStaffBadgeTooltip(String productName) {
    return 'Екип на $productName';
  }

  @override
  String userProfileCtpBadgeTooltip(String productName) {
    return 'Екип на общността на $productName';
  }

  @override
  String userProfilePartnerBadgeTooltip(String productName) {
    return 'Партньор на $productName';
  }

  @override
  String userProfileBugHunterBadgeTooltip(String productName) {
    return 'Ловец на бъгове в $productName';
  }

  @override
  String userProfilePremiumSubscriberSinceTooltip(
    String premiumProductFullName,
    String date,
  ) {
    return 'Абонат на $premiumProductFullName от $date';
  }

  @override
  String userProfileVisionaryBadgeTooltip(String productName) {
    return '$productName визионер';
  }

  @override
  String userProfileVisionaryBadgeSinceTooltip(
    String productName,
    String date,
  ) {
    return '$productName Визионер от $date';
  }

  @override
  String userProfileVisionaryIdTooltip(int sequence) {
    return 'ID на визионер #$sequence';
  }

  @override
  String userProfileMutualFriends(int count) {
    return 'Общи приятели ($count)';
  }

  @override
  String userProfileMutualCommunities(int count) {
    return 'Общи общности ($count)';
  }

  @override
  String get userProfileMutualFriendsTitle => 'Общи приятели';

  @override
  String get userProfileMutualCommunitiesTitle => 'Общи общности';

  @override
  String get userProfileNoMutualFriends => 'Няма намерени общи приятели.';

  @override
  String get userProfileNoMutualCommunities => 'Няма намерени общи общности.';

  @override
  String userProfileMutualCommunityNickname(String nickname) {
    return 'Прякор: $nickname';
  }

  @override
  String get userProfileOpenBlockedDmTitle => 'Отвори чат';

  @override
  String userProfileOpenBlockedDmDescription(String username) {
    return 'Блокирахте $username. Няма да можете да изпращате съобщения, освен ако не го отблокирате.';
  }

  @override
  String get blockedUserComposerBarrierAction => 'Отблокиране';

  @override
  String get userProfileOpenDm => 'Отвори чат';

  @override
  String get userProfileNoteTitle => 'Бележка';

  @override
  String get userProfileNoteVisibility => '(видимо само за вас)';

  @override
  String get userProfileNoteSave => 'Запазване';

  @override
  String get userProfileNoteDelete => 'Изтриване';

  @override
  String get userProfileMemberSince => 'Член от';

  @override
  String get userProfileAboutMe => 'За мен';

  @override
  String get userProfileRoles => 'Роли';

  @override
  String get memberRoleAdd => 'Добавяне на роля';

  @override
  String memberRoleRemove(String roleName) {
    return 'Премахване на роля $roleName';
  }

  @override
  String get userProfileNoRolesInCommunity =>
      'Този потребител няма роли в тази общност.';

  @override
  String memberRolesNoRolesYet(String rolesSettingsPath) {
    return 'Все още няма роли. Добавете роли в $rolesSettingsPath';
  }

  @override
  String get memberRolesNoRolesAvailable => 'Няма налични роли';

  @override
  String memberRolesNoRolesAvailableDescription(String rolesSettingsPath) {
    return 'В момента няма роли за назначаване в тази общност, но можете да създадете нова роля в $rolesSettingsPath.';
  }

  @override
  String get guildSettingsTitle => 'Настройки на общността';

  @override
  String get guildSettingsRolesTab => 'Роли';

  @override
  String get memberRolesConfirmOk => 'OK';

  @override
  String get userProfileLocalTime => 'Местно време';

  @override
  String get profileLocalTimeSettingsTitle => 'Местно време в профила';

  @override
  String profileLocalTimeSettingsSummary(String productName) {
    return 'Задай часовата си зона веднъж, за да може $productName да поддържа разликата ти от UTC актуална при смяна на лятното часово време. Другите хора виждат само разликата ти от UTC, а не точния идентификатор на часовата ти зона.';
  }

  @override
  String get profileLocalTimeEditButton =>
      'Редактиране на местно време в профила';

  @override
  String get profileLocalTimeTimezoneLabel => 'Часова зона';

  @override
  String profileLocalTimeTimezoneHelp(String productName) {
    return 'Избери часовата зона, която $productName използва, за да изчисли отместването ти от UTC за локалното време в профила.';
  }

  @override
  String get profileLocalTimeSearchTimezones => 'Търсене на часови зони';

  @override
  String get profileLocalTimeNotSet => 'Не е зададено';

  @override
  String profileLocalTimePrivacyNote(
    String timezoneIdentifierExample,
    String productName,
  ) {
    return 'Другите потребители могат да виждат само текущото ти UTC отместване, когато избереш да споделяш локалното време в профила си. Те не виждат точния идентификатор на часовата ти зона, като например $timezoneIdentifierExample. $productName съхранява този идентификатор само за да може отместването автоматично да се актуализира при промяна на лятното часово време.';
  }

  @override
  String get profileLocalTimePrivacyEveryone => 'Всеки';

  @override
  String get profileLocalTimePrivacyEveryoneDesc =>
      'Позволява на всеки, който може да вижда пълния ти профил, да вижда местното ти време';

  @override
  String get profileLocalTimePrivacyFriends => 'Приятели';

  @override
  String get profileLocalTimePrivacyFriendsDesc =>
      'Позволява на приятелите ти да виждат местното ти време';

  @override
  String get profileLocalTimePrivacyCommunityMembers => 'Членове на общността';

  @override
  String get profileLocalTimePrivacyCommunityMembersDesc =>
      'Позволява на членовете на общностите, в които си, да виждат местното ти време';

  @override
  String get userProfileSameTimeAsYou => 'В същия часови пояс като вас';

  @override
  String userProfileTimeAheadOfYou(String duration) {
    return '$duration пред вас';
  }

  @override
  String userProfileTimeBehindYou(String duration) {
    return 'с $duration след вас';
  }

  @override
  String userProfileTimezoneDurationHoursMinutes(int hours, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours часа',
      one: '1 час',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes минути',
      one: '1 минута',
    );
    return '$_temp0 $_temp1';
  }

  @override
  String userProfileTimezoneDurationHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours часа',
      one: '1 час',
    );
    return '$_temp0';
  }

  @override
  String userProfileTimezoneDurationMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes минути',
      one: '1 минута',
    );
    return '$_temp0';
  }

  @override
  String get userProfileCopyUsername => 'Копирай потребителско име';

  @override
  String get userProfileCopyUserId => 'Копирай потребителски ID';

  @override
  String get userProfileViewMainProfile => 'Преглед на основния профил';

  @override
  String get userProfileViewCommunityProfile =>
      'Преглед на профила на общността';

  @override
  String get userProfileBlockUser => 'Блокирай потребителя';

  @override
  String get userProfileUnblockUser => 'Отблокирай потребителя';

  @override
  String get userProfileRemoveFriend => 'Премахни приятел';

  @override
  String get userProfileBlockConfirmTitle => 'Блокиране на потребител';

  @override
  String userProfileBlockConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да блокирате $username?';
  }

  @override
  String get userProfileUnblockConfirmTitle => 'Отблокиране на потребител';

  @override
  String userProfileUnblockConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да премахнете $username от черния списък?';
  }

  @override
  String get userProfileRemoveFriendConfirmTitle => 'Премахни приятел';

  @override
  String userProfileRemoveFriendConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да премахнете $username като приятел?';
  }

  @override
  String get userProfileFailedSaveNote => 'Неуспешно запазване на бележката';

  @override
  String get userProfileChangeNickname => 'Промяна на прякор';

  @override
  String get userProfileKick => 'Изключване';

  @override
  String get userProfileBan => 'Забраняване';

  @override
  String get userProfileTimeout => 'Време за изчакване';

  @override
  String get userProfileRemoveTimeout => 'Премахване на изчакване';

  @override
  String get userProfileTransferOwnership => 'Прехвърляне на собственост';

  @override
  String get userProfileReportMessage => 'Докладване на съобщение';

  @override
  String get userProfileReportUserProfile => 'Докладване на профил';

  @override
  String userProfileKickConfirmTitle(String username) {
    return 'Изгонване на $username?';
  }

  @override
  String userProfileKickConfirmDescription(String username) {
    return 'Сигурни ли сте, че искате да изгоните $username? Той/тя може да се присъедини отново с нова покана.';
  }

  @override
  String get userProfileRemoveTimeoutConfirmTitle => 'Премахване на забрана?';

  @override
  String userProfileRemoveTimeoutConfirmDescription(String username) {
    return 'Премахването на забраната ще позволи на $username отново да изпраща съобщения, да реагира и да се присъединява към гласови канали.';
  }

  @override
  String get userProfileTransferConfirmTitle => 'Прехвърляне на собствеността?';

  @override
  String userProfileTransferConfirmDescription(String username) {
    return 'Прехвърляне на собствеността на тази общност на $username? Това е необратимо и ще загубите всички права на собственик.';
  }

  @override
  String userProfileBanSheetTitle(String username) {
    return 'Забрани $username';
  }

  @override
  String get userProfileBanDurationLabel => 'Продължителност на забраната';

  @override
  String get userProfileBanCustomSecondsLabel =>
      'Персонализирана продължителност (секунди)';

  @override
  String userProfileBanCustomSecondsHelper(int min, int max) {
    return 'Всяка стойност от $min до $max секунди';
  }

  @override
  String get userProfileBanDeleteHistoryLabel =>
      'Изтриване на историята на съобщенията';

  @override
  String get userProfileBanDeleteNone => 'Не изтривай нито едно';

  @override
  String get userProfileBanDelete24h => 'Предишни 24 часа';

  @override
  String get userProfileBanDelete7d => 'Предишни 7 дни';

  @override
  String get userProfileBanReasonLabel => 'Причина (по избор)';

  @override
  String get userProfileBanReasonHint => 'Въведете причина за забраната';

  @override
  String get userProfileBanSubmit => 'Забрани потребител';

  @override
  String userProfileTimeoutSheetTitle(String username) {
    return 'Временно блокиране на $username';
  }

  @override
  String get userProfileTimeoutDurationLabel =>
      'Продължителност на временното ограничение';

  @override
  String get userProfileTimeoutSubmit => 'Временно отстраняване на член';

  @override
  String get userProfileNicknameLabel => 'Псевдоним';

  @override
  String get userProfileNicknameHint => 'Въведете прякор';

  @override
  String get userProfileNicknameSave => 'Запазване';

  @override
  String userProfileKickSuccess(String username) {
    return 'Изритаxме $username';
  }

  @override
  String userProfileBanSuccess(String username) {
    return 'Забранен $username';
  }

  @override
  String userProfileTimeoutSuccess(String username) {
    return 'Забраних достъпа на $username';
  }

  @override
  String userProfileRemoveTimeoutSuccess(String username) {
    return 'Премахнах времето за изчакване за $username';
  }

  @override
  String get userProfileNicknameSuccess => 'Псевдонимът е актуализиран';

  @override
  String get userProfileTransferSuccess => 'Собствеността е прехвърлена';

  @override
  String get durationPermanent => 'Постоянно';

  @override
  String get duration60Seconds => '60 секунди';

  @override
  String get duration5Minutes => '5 минути';

  @override
  String get duration10Minutes => '10 минути';

  @override
  String get duration1Hour => '1 час';

  @override
  String get duration12Hours => '12 часа';

  @override
  String get duration1Day => '1 ден';

  @override
  String get duration3Days => '3 дни';

  @override
  String get duration5Days => '5 дни';

  @override
  String get duration1Week => '1 седмица';

  @override
  String get duration2Weeks => '2 седмици';

  @override
  String get duration1Month => '1 месец';

  @override
  String get durationCustom => 'По избор…';

  @override
  String typingIndicatorOne(String name) {
    return '$name пише...';
  }

  @override
  String typingIndicatorTwo(String name1, String name2) {
    return '$name1 и $name2 пишат...';
  }

  @override
  String typingIndicatorThree(String name1, String name2, String name3) {
    return '$name1, $name2 и $name3 пишат...';
  }

  @override
  String get typingIndicatorMultiple => 'Няколко души пишат...';

  @override
  String get typingIndicatorHandful => 'Няколко души пишат...';

  @override
  String get typingIndicatorSymphony => 'Някой пише...';

  @override
  String get typingIndicatorFiesta => 'Тук е пълна фиеста от писане';

  @override
  String get typingIndicatorApocalypse => 'Леле, настава апокалипсис от писане';

  @override
  String systemJoinGladYoureHere(String username) {
    return 'Радваме се, че си тук, $username!';
  }

  @override
  String systemJoinWelcomeMakeYourselfAtHome(String username) {
    return 'Добре дошъл, $username! Чувствай се като у дома си.';
  }

  @override
  String systemJoinHelloNiceToHaveYouHere(String username) {
    return 'Здравейте, $username! Приятно ни е, че сте тук.';
  }

  @override
  String systemJoinHelloJumpInWheneverYoureReady(String username) {
    return 'Здравейте, $username! Присъединете се, когато сте готови.';
  }

  @override
  String systemJoinHeyGreatToSeeYouHere(String username) {
    return 'Здравейте, $username, радваме се да ви видим тук!';
  }

  @override
  String systemJoinHeyThereHopeYouEnjoyYourStay(String username) {
    return 'Здравейте, $username! Надявам се да ви хареса престоят.';
  }

  @override
  String systemJoinHeyWelcomeAboard(String username) {
    return 'Здравейте, $username, добре дошли!';
  }

  @override
  String systemJoinGladYouMadeIt(String username) {
    return 'Радваме се, че си тук, $username!';
  }

  @override
  String systemJoinWelcomeIn(String username) {
    return 'Добре дошъл, $username!';
  }

  @override
  String systemJoinWelcome(String username) {
    return 'Добре дошъл, $username!';
  }

  @override
  String systemJoinWelcomeWereGladYoureHere(String username) {
    return 'Добре дошъл, $username! Радваме се, че си тук.';
  }

  @override
  String systemJoinWelcomeHopeYouEnjoyYourTimeHere(String username) {
    return 'Добре дошъл, $username! Надяваме се да си прекараш добре тук.';
  }

  @override
  String systemJoinWelcomeYourNextConversationStartsHere(String username) {
    return 'Добре дошъл, $username! Следващият ти разговор започва тук.';
  }

  @override
  String systemJoinWelcomeWereHappyToHaveYouHere(String username) {
    return 'Добре дошъл, $username. Радваме се да си тук.';
  }

  @override
  String systemJoinGreatToSeeYouWelcomeIn(String username) {
    return 'Приятно ни е да те видим, $username! Добре дошъл.';
  }

  @override
  String systemJoinYoureHereGoodToHaveYouWithUs(String username) {
    return 'Вече си тук, $username! Радваме се, че си с нас.';
  }

  @override
  String systemJoinYouveArrivedLetsGetStarted(String username) {
    return 'Пристигна, $username! Да започваме.';
  }

  @override
  String get relativeTimeShortNow => 'сега';

  @override
  String relativeTimeShortMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count мин.',
      one: '1 мин.',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeShortHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ч.',
      one: '1 ч.',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeShortDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countд',
      one: '1д',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeShortMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count мес.',
      one: '1 мес.',
    );
    return '$_temp0';
  }

  @override
  String relativeTimeShortYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count г.',
      one: '1 г.',
    );
    return '$_temp0';
  }

  @override
  String get linkedDevicesTitle => 'Моите устройства';

  @override
  String get linkedDevicesDescription =>
      'Вижте всички устройства, които в момента са влезли в профила ви. Отменете всички сесии, които не разпознавате.';

  @override
  String get linkedDevicesCurrentDevice => 'Текущо устройство';

  @override
  String get linkedDevicesOtherDevices => 'Други устройства';

  @override
  String get linkedDevicesEnterSelection => 'Влез в режим на избор';

  @override
  String get linkedDevicesExitSelection => 'Изход от режим на избор';

  @override
  String get linkedDevicesSelectAll => 'Избери всички';

  @override
  String get linkedDevicesClearSelection => 'Изчисти селекцията';

  @override
  String get linkedDevicesRevokeTooltip => 'Отмяна на достъп';

  @override
  String get linkedDevicesSignOutAll => 'Излизане от всички други устройства';

  @override
  String linkedDevicesSignOutN(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Изход от $count устройства',
      one: 'Изход от 1 устройство',
    );
    return '$_temp0';
  }

  @override
  String linkedDevicesSignOutSheetTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Изход от $count устройства',
      one: 'Изход от 1 устройство',
    );
    return '$_temp0';
  }

  @override
  String get linkedDevicesSignOutAllSheetTitle =>
      'Излизане от всички други устройства';

  @override
  String linkedDevicesSignOutSheetDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Това ще излезе от избраните устройства от профила ви. Ще трябва да влезете отново на тези устройства.',
      one:
          'Това ще излезе от избраното устройство от профила ви. Ще трябва да влезете отново на това устройство.',
    );
    return '$_temp0';
  }

  @override
  String get linkedDevicesSignOutAllSheetDescription =>
      'Това ще изтрие данните за вход от избраните устройства. Ще трябва да влезете отново на тези устройства.';

  @override
  String get linkedDevicesSignOutConfirm => 'Продължи';

  @override
  String get linkedDevicesLogoutDisclaimer =>
      'Ще трябва да влезете отново на всички излезли устройства';

  @override
  String get linkedDevicesLoadErrorTitle => 'Мрежова грешка';

  @override
  String get linkedDevicesLoadErrorDescription =>
      'Имаме проблем с връзката към пространствено-времевия континуум. Моля, проверете връзката си и опитайте отново.';

  @override
  String linkedDevicesRevokeSuccess(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Устройствата са отнети',
      one: 'Устройството е отнето',
    );
    return '$_temp0';
  }

  @override
  String get linkedDevicesRevokeError =>
      'Не успяхме да излезем. Опитайте отново.';

  @override
  String get linkedDevicesUnknownOs => 'Неизвестна ОС';

  @override
  String get linkedDevicesUnknownPlatform => 'Неизвестна платформа';

  @override
  String get linkedDevicesViewDetails => 'Преглед на подробности';

  @override
  String get linkedDevicesDetailsTitle => 'Подробности за устройството';

  @override
  String get linkedDevicesDetailsDevice => 'Устройство';

  @override
  String get linkedDevicesDetailsClient => 'Клиент';

  @override
  String get linkedDevicesDetailsLocation => 'Местоположение';

  @override
  String get linkedDevicesDetailsIp => 'IP адрес';

  @override
  String get linkedDevicesDetailsLastUsed => 'Последно използван';

  @override
  String get linkedDevicesCurrentSession => 'Текуща сесия';

  @override
  String get linkedDevicesUnknown => 'Неизвестен';

  @override
  String slowmodeLabel(String duration) {
    return '$duration бавен режим';
  }

  @override
  String get slowmodeTooltipActive =>
      'Вие сте в режим на забавяне. Моля, изчакайте, преди да изпратите друго съобщение.';

  @override
  String get slowmodeTooltipImmune =>
      'Бавният режим е включен, но вие сте имунизирани.';

  @override
  String get slowmodeStatusEnabled => 'Бавен режим е включен';

  @override
  String slowmodeStatusActive(String remaining) {
    return 'Бавен режим е активен ($remaining)';
  }

  @override
  String slowmodeTooltipSetImmune(String durationLabel) {
    return 'Бавен режим е зададен на $durationLabel, но вие сте освободен.';
  }

  @override
  String slowmodeTooltipSetWait(String durationLabel) {
    return 'Бавен режим е зададен на $durationLabel. Изчакайте, преди да изпратите друго съобщение.';
  }

  @override
  String slowmodeTooltipSetChannel(String durationLabel) {
    return 'Бавен режим е зададен на $durationLabel за този канал.';
  }

  @override
  String get channelNoSendPermissionHint =>
      'Нямате право да изпращате съобщения в този канал.';

  @override
  String systemDmComposerBarrier(String productName) {
    return 'Системни съобщения от екипа на $productName. Тук не може да отговаряте.';
  }

  @override
  String get channelComposerBarrierGuildSendDisabled =>
      'Изпращането на съобщения е временно спряно в тази общност.';

  @override
  String get channelComposerBarrierTimedOut =>
      'Времето ви изтече. Изпращането на съобщения, реакциите и гласовите съобщения са на пауза, докато изтече наказанието.';

  @override
  String get channelComposerBarrierUnclaimedAccount =>
      'Трябва да потвърдите профила си, за да изпращате съобщения в тази общност.';

  @override
  String get channelComposerBarrierUnverifiedEmail =>
      'Трябва да потвърдите имейла си, за да изпращате съобщения в тази общност.';

  @override
  String get channelComposerBarrierAccountTooNew =>
      'Профилът ви е твърде нов, за да изпращате съобщения в тази общност.';

  @override
  String get channelComposerBarrierNotMemberLongEnough =>
      'Не сте член на тази общност от достатъчно дълго време, за да изпращате съобщения.';

  @override
  String get channelComposerBarrierVerifyEmail => 'Потвърдете имейл';

  @override
  String get accountLimitedNotice =>
      'Изпращането на съобщения от акаунта ти е на пауза. Погледни имейла си: остава само една бърза стъпка, за да продължиш.';

  @override
  String get messagingPausedTextDidNotGoThrough => 'SMS-ът ми не пристигна';

  @override
  String messagingPausedHelpBody(String supportEmail) {
    return 'Пиши на $supportEmail и човек от екипа ще провери акаунта ти. Можеш и да отговориш на имейла, който ти изпратихме.';
  }

  @override
  String get messagingPausedHelpCountryLabel => 'Държавата, в която се намираш';

  @override
  String get messagingPausedHelpCopyDetails => 'Копирай данните';

  @override
  String get messagingPausedHelpEmailSupport => 'Пиши на поддръжката';

  @override
  String messagingPausedHelpAccountIdLine(String accountId) {
    return 'ID на акаунта: $accountId';
  }

  @override
  String messagingPausedHelpUsernameLine(String username) {
    return 'Потребителско име: $username';
  }

  @override
  String messagingPausedHelpAccountCreatedLine(String createdAt) {
    return 'Акаунтът е създаден: $createdAt';
  }

  @override
  String messagingPausedHelpCountryLine(String country) {
    return 'Държава: $country';
  }

  @override
  String get chatAttachmentPayloadTooLarge =>
      'Тези файлове са твърде големи, за да бъдат изпратени заедно';

  @override
  String get chatAttachmentDropToUpload => 'Пуснете файлове за качване';

  @override
  String get chatAttachmentDropToSend =>
      'Пусни файловете, за да ги изпратиш сега';

  @override
  String get voiceMessageTitle => 'Гласово съобщение';

  @override
  String get voiceMessageHoldHint =>
      'Задръжте, за да запишете. Плъзнете към кошчето, за да изтриете, плъзнете нагоре, за да заключите, или пуснете, за да изпратите.';

  @override
  String get voiceMessageDiscard => 'Изтриване на гласово съобщение';

  @override
  String get voiceMessageSend => 'Изпращане на гласово съобщение';

  @override
  String get voiceMessageMicPermissionDenied =>
      'Не може да се започне запис. Разрешете достъп до микрофона.';

  @override
  String get voiceMessageMicInUse =>
      'Напуснете гласовото повикване, за да запишете гласово съобщение.';

  @override
  String get voiceMessageRecordingFailed =>
      'Записът не бе успешен. Опитайте отново.';

  @override
  String get voiceMessageSendFailed =>
      'Гласовото съобщение не може да бъде изпратено. Опитайте отново.';

  @override
  String get voiceMessagePlay => 'Пусни';

  @override
  String get voiceMessagePause => 'Пауза';

  @override
  String get voiceMessageSeekForward => 'Пренавий напред';

  @override
  String get voiceMessageSeekBackward => 'Пренавиване назад';

  @override
  String get chatAttachmentEditTitle => 'Редактиране на прикачен файл';

  @override
  String get chatAttachmentFilenameLabel => 'Име на файла';

  @override
  String get chatAttachmentDescriptionLabel => 'Описание';

  @override
  String get chatAttachmentDescriptionHint =>
      'Незадължителен алтернативен текст';

  @override
  String get chatAttachmentSpoilerLabel => 'Маркирай като спойлер';

  @override
  String get chatAttachmentRemove => 'Премахване на прикачен файл';

  @override
  String get chatAttachmentDownload => 'Изтегляне';

  @override
  String get chatAttachmentDownloadedToast => 'Запазено в снимки';

  @override
  String get chatAttachmentDownloadFailedToast =>
      'Не успях да изтегля прикачения файл';

  @override
  String get chatAttachmentExpiredTooltip => 'Прикаченият файл е изтекъл';

  @override
  String chatTextualPreviewExpandLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Разгъни ($count реда)',
      one: 'Разгъни ($count ред)',
    );
    return '$_temp0';
  }

  @override
  String chatTextualPreviewCollapseLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Скрий ($count реда)',
      one: 'Скрий ($count ред)',
    );
    return '$_temp0';
  }

  @override
  String chatTextualPreviewExpandRows(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Разгъни ($count реда)',
      one: 'Разгъни ($count ред)',
    );
    return '$_temp0';
  }

  @override
  String chatTextualPreviewCollapseRows(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Свий ($count реда)',
      one: 'Свий ($count ред)',
    );
    return '$_temp0';
  }

  @override
  String chatTextualPreviewRemainingLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '... (остават $count реда)',
      one: '... (остава $count ред)',
    );
    return '$_temp0';
  }

  @override
  String chatTextualPreviewRemainingRows(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '... (остават $count реда)',
      one: '... (остава $count ред)',
    );
    return '$_temp0';
  }

  @override
  String get chatTextualPreviewViewWholeFile => 'Преглед на целия файл';

  @override
  String get chatTextualPreviewChangeLanguage => 'Смяна на езика';

  @override
  String get chatTextualPreviewSearchLanguage => 'Търсене на език…';

  @override
  String get chatTextualPreviewSyntaxHighlighting => 'Синтактично оцветяване';

  @override
  String get chatTextualPreviewNoLanguagesFound => 'Няма намерени резултати';

  @override
  String get chatTextualPreviewMoreOptions => 'Още опции';

  @override
  String get chatTextualPreviewWrapText => 'Пренасяне на текст';

  @override
  String chatTextualPreviewSizeError(int previewLimitKb) {
    return 'Файлът е твърде голям за вграден преглед (лимит $previewLimitKb KB).';
  }

  @override
  String get chatTextualPreviewLoadError => 'Не може да се зареди преглед.';

  @override
  String get chatTextualPreviewLanguagePlaintext => 'Обикновен текст';

  @override
  String get chatTextualPreviewCopy => 'Копирай';

  @override
  String get chatAttachmentSourceGallery => 'Галерия';

  @override
  String get chatAttachmentSourceCamera => 'Камера';

  @override
  String get chatAttachmentSourceBrowse => 'Преглед на файлове';

  @override
  String get chatAttachmentSpoiler => 'Спойлер';

  @override
  String get chatMediaSpoilerOverlayLabel => 'СПОЙЛЕР';

  @override
  String get chatMediaSpoilerRevealLabel => 'Покажи спойлера';

  @override
  String get matureMediaRevealButton => 'Покажи';

  @override
  String get matureMediaRevealHint => 'Натиснете, за да видите';

  @override
  String get matureContentTitle => 'Съдържание за възрастни';

  @override
  String get matureCommunityTitle => 'Общност за възрастни';

  @override
  String get matureCategoryTitle => 'Категория за възрастни';

  @override
  String get matureChannelTitle => 'Канал за възрастни';

  @override
  String get communityContentWarningTitle =>
      'Предупреждение за съдържание от общността';

  @override
  String get categoryContentWarningTitle =>
      'Предупреждение за съдържание в категорията';

  @override
  String get channelContentWarningTitle =>
      'Предупреждение за съдържанието на канала';

  @override
  String get defaultContentWarningBody =>
      'Това съдържа чувствително съдържание.';

  @override
  String get matureCommunityBody =>
      'Тази общност е обозначена като съдържаща съдържание за възрастни и може да включва материали, които са неподходящи за някои потребители.';

  @override
  String get matureCategoryBody =>
      'Тази категория е обозначена за зряло съдържание и може да съдържа материали, които са неподходящи за някои потребители.';

  @override
  String get matureChannelBody =>
      'Този канал е маркиран за съдържание за възрастни и може да съдържа материали, които са неподходящи за някои потребители.';

  @override
  String get matureVoiceChannelBody =>
      'Този гласов канал е маркиран за съдържание за възрастни и може да съдържа материали, които са неподходящи за някои потребители.';

  @override
  String get matureLinkChannelBody =>
      'Този канал с връзки е маркиран за съдържание за възрастни и може да отваря материали, които може да са неподходящи за някои потребители.';

  @override
  String get matureCommunityUnavailableBody =>
      'Тази общност за възрастни не е достъпна за профила ви.';

  @override
  String get matureCategoryUnavailableBody =>
      'Тази категория за възрастни не е достъпна за вашия акаунт.';

  @override
  String get matureChannelUnavailableBody =>
      'Този канал за възрастни не е наличен за вашия акаунт.';

  @override
  String get matureContentProceedButton => 'Продължи';

  @override
  String get matureContentUnderstandButton => 'Разбрах';

  @override
  String get matureContentOpenLinkButton => 'Отваряне на връзка';

  @override
  String get sensitiveContentFriendDmLabel => 'Директни съобщения от приятели';

  @override
  String get sensitiveContentNonFriendDmLabel =>
      'Директни съобщения от други потребители';

  @override
  String get sensitiveContentGuildLabel => 'Съобщения в канали на общността';

  @override
  String get sensitiveContentFilterShow => 'Покажи';

  @override
  String get sensitiveContentFilterBlur => 'Размазване';

  @override
  String get sensitiveContentFilterBlock => 'Блокиране';

  @override
  String get sensitiveContentResetButton => 'Нулиране';

  @override
  String get sensitiveContentSaveButton => 'Запазване';

  @override
  String chatUploadingAttachmentsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла',
      one: '1 файл',
    );
    return 'Качване на $_temp0';
  }

  @override
  String chatAttachmentExpiresOn(String date) {
    return 'Изтича на $date';
  }

  @override
  String chatAttachmentExpiresBetween(String start, String end) {
    return 'Изтича между $start и $end';
  }

  @override
  String get connectionsTitle => 'Връзки';

  @override
  String connectionsDescription(String productName) {
    return 'Свържете външни акаунти и домейни към вашия профил в $productName. Потвърдените връзки ще бъдат показани в профила ви, за да ги виждат другите.';
  }

  @override
  String get connectionsEmptyTitle => 'Все още няма връзки';

  @override
  String get connectionsEmptyDescriptionBluesky =>
      'Свържете своя Bluesky акаунт или потвърдете собствеността на домейн, за да ги покажете в профила си.';

  @override
  String get connectionsEmptyDescriptionDomainOnly =>
      'Потвърдете собствеността на домейна, за да го покажете в профила си.';

  @override
  String get connectionsAddBluesky => 'Bluesky';

  @override
  String get connectionsAddDomain => 'Домейн';

  @override
  String get connectionsAddBlueskyAriaLabel => 'Добавяне на връзка към Bluesky';

  @override
  String get connectionsAddDomainAriaLabel => 'Добавяне на връзка с домейн';

  @override
  String get connectionEdit => 'Редактиране';

  @override
  String get connectionRemove => 'Премахване';

  @override
  String get connectionVerifiedLabel => 'Тази връзка е потвърдена.';

  @override
  String get connectionUnverifiedLabel => 'Тази връзка не е потвърдена.';

  @override
  String get connectionAddTitle => 'Добавяне на връзка';

  @override
  String get connectionTypeLabel => 'Тип връзка';

  @override
  String get connectionHandleLabel => 'Псевдоним';

  @override
  String get connectionDomainLabel => 'Домейн';

  @override
  String get connectionHandlePlaceholder => 'username.bsky.social';

  @override
  String get connectionDomainPlaceholder => 'example.com';

  @override
  String get connectionAlreadyExists => 'Вече имате тази връзка.';

  @override
  String get connectionConnectBluesky => 'Свързване с Bluesky';

  @override
  String get connectionContinue => 'Продължи';

  @override
  String get connectionVerifyTitle => 'Потвърждаване на връзката';

  @override
  String get connectionVerifyInstructions =>
      'Използвайте записа по-долу, за да докажете собствеността върху домейна.';

  @override
  String get connectionDnsRecordTitle => 'DNS TXT запис';

  @override
  String get connectionDnsHostLabel => 'Домакин';

  @override
  String get connectionDnsValueLabel => 'Стойност';

  @override
  String get connectionCopyHost => 'Копирай хост';

  @override
  String get connectionCopyValue => 'Копирай стойността';

  @override
  String get connectionCopied => 'Копирано!';

  @override
  String get connectionTokenFileTitle => 'Предоставяне на токен файл';

  @override
  String get connectionTokenFileDescription =>
      'Изтеглете **fluxer-verification** и го поставете във вашата папка **.well-known**, за да можем да потвърдим домейна.';

  @override
  String get connectionTokenFileDownload => 'Изтегляне на fluxer-verification';

  @override
  String connectionTokenFileMeta(String dnsUrl) {
    return 'Файлът съдържа токена за проверка, който ще извлечем от **$dnsUrl**.';
  }

  @override
  String get connectionSaveTokenDialogTitle =>
      'Запазване на fluxer-verification';

  @override
  String get connectionVerifyButton => 'Потвърди';

  @override
  String get connectionBack => 'Назад';

  @override
  String get connectionEditTitle => 'Редактиране на връзка';

  @override
  String get connectionEditDescription =>
      'Изберете кой да вижда тази връзка в профила ви.';

  @override
  String get connectionVisibilityEveryone => 'Всеки';

  @override
  String get connectionVisibilityEveryoneDesc =>
      'Позволяване на всеки да вижда тази връзка в профила ви';

  @override
  String get connectionVisibilityFriends => 'Приятели';

  @override
  String get connectionVisibilityFriendsDesc =>
      'Позволете на приятелите си да виждат тази връзка';

  @override
  String get connectionVisibilityCommunityMembers => 'Членове на общността';

  @override
  String get connectionVisibilityCommunityMembersDesc =>
      'Позволи на членове от общностите, в които членуваш, да виждат тази връзка';

  @override
  String get connectionRemoveTitle => 'Премахни връзката';

  @override
  String get connectionRemoveDescription =>
      'Сигурни ли сте, че искате да премахнете тази връзка? Тази операция не може да бъде отменена.';

  @override
  String get connectionRemoveConfirm => 'Премахване';

  @override
  String get connectionsLoadError => 'Неуспешно зареждане на връзките';

  @override
  String get connectionsReorderError => 'Неуспешно обновяване на реда';

  @override
  String get connectionInitiateFailed =>
      'Не успях да стартирам проверката. Опитайте отново.';

  @override
  String get connectionVerifyFailed =>
      'Не успяхме да потвърдим. Проверете DNS записа си и опитайте отново.';

  @override
  String get connectionBlueskyAuthorizeFailed =>
      'Не успяхме да стартираме оторизацията за Bluesky.';

  @override
  String get connectionUpdateFailed => 'Не успях да обновя връзката';

  @override
  String get connectionRemoveFailed => 'Не успях да премахна връзката';

  @override
  String get connectionTokenSavedToast => 'Fluxer-верификацията е запазена';

  @override
  String get connectionTokenSaveFailedToast => 'Не успях да запазя файла';

  @override
  String get connectionEnterHandle => 'Въведете Bluesky потребителско име.';

  @override
  String get connectionEnterDomain => 'Въведете домейн.';

  @override
  String get lookAndFeelThemeSectionTitle => 'Тема';

  @override
  String get lookAndFeelThemeSectionDescription =>
      'Изберете между тъмен, въглищен или светъл изглед.';

  @override
  String get lookAndFeelHdrSectionTitle => 'Висок динамичен обхват';

  @override
  String get lookAndFeelHdrSectionDescription =>
      'Контролирайте как се показват HDR изображенията на HDR-съвместими монитори.';

  @override
  String get lookAndFeelHdrFullName => 'Пълен динамичен обхват';

  @override
  String get lookAndFeelHdrFullDescription =>
      'Показване на HDR изображения с пълна яркост и цветови диапазон.';

  @override
  String get lookAndFeelHdrStandardName => 'Стандартен обхват';

  @override
  String get lookAndFeelHdrStandardDescription =>
      'Преобразуване на HDR изображения в стандартен диапазон, намалявайки пиковата яркост.';

  @override
  String get lookAndFeelHdrDisplayModeLabel =>
      'Режим на дисплея с висок динамичен обхват';

  @override
  String get lookAndFeelThemeDark => 'Тъмна тема';

  @override
  String get lookAndFeelThemeDarkLegacy => 'Тъмна (наследена) тема';

  @override
  String get lookAndFeelThemeCoal => 'Тема „Въглен“';

  @override
  String get lookAndFeelThemeLight => 'Светла тема';

  @override
  String get lookAndFeelThemeSystem => 'Системна тема';

  @override
  String get lookAndFeelSyncThemeAcrossDevicesLabel =>
      'Синхронизиране на темата между устройствата';

  @override
  String get lookAndFeelSyncThemeAcrossDevicesDescription =>
      'Когато е включено, промените в темата ще се синхронизират с всички ваши устройства. Когато е изключено, това устройство ще използва собствената си настройка за тема.';

  @override
  String get lookAndFeelSyncThemeAcrossDevicesSystemDescription =>
      'Системната тема автоматично деактивира синхронизацията, за да следи предпочитанията на вашата система на това устройство.';

  @override
  String get lookAndFeelThemeSyncFailed =>
      'Не успяхме да синхронизираме темата с вашия акаунт. Моля, опитайте отново.';

  @override
  String get lookAndFeelThemeColorsTitle => 'Цветове на темата';

  @override
  String get lookAndFeelThemeColorsConfigureDescription =>
      'Персонализирай отделните цветове на темата за това устройство.';

  @override
  String lookAndFeelThemeColorsEditingMode(String mode) {
    return 'Редактиране: $mode';
  }

  @override
  String get lookAndFeelThemeColorsSyncSectionTitle =>
      'Синхронизиране с Theme Studio';

  @override
  String get lookAndFeelThemeColorsSyncFromStudioLabel =>
      'Използване на цветовете от Theme Studio';

  @override
  String get lookAndFeelThemeColorsSyncFromStudioDescription =>
      'Когато е включено, промените в цветовете от Theme Studio на компютъра се прилагат и на това устройство. Когато е изключено, това устройство запазва собствените си цветове.';

  @override
  String get lookAndFeelThemeColorsSyncToStudioLabel =>
      'Изпращане на промените в цветовете към Theme Studio';

  @override
  String get lookAndFeelThemeColorsSyncToStudioDescription =>
      'Когато е включено, цветовете, които промениш тук, се синхронизират с Theme Studio на другите ти устройства. Когато е изключено, Theme Studio на компютъра запазва собствените си цветове.';

  @override
  String get lookAndFeelThemeColorsSyncFromStudioOffBanner =>
      'Промените в цветовете от Theme Studio на компютъра няма да се прилагат на това устройство.';

  @override
  String get lookAndFeelThemeColorsEssentialSectionTitle => 'Основни цветове';

  @override
  String get lookAndFeelThemeColorsChatBackgroundWallpaperNote =>
      'Ако имаш зададен тапет на чата, няма да виждаш този цвят.';

  @override
  String lookAndFeelThemeColorsResetForMode(String mode) {
    return 'Нулиране на всички цветове за $mode';
  }

  @override
  String get lookAndFeelThemeColorsResetConfirmTitle =>
      'Нулиране на цветовете на темата?';

  @override
  String lookAndFeelThemeColorsResetConfirmBody(String mode) {
    return 'Това премахва персонализираните ти цветове за $mode на това устройство.';
  }

  @override
  String get lookAndFeelThemeColorsGroupBrandButtons => 'Марка и бутони';

  @override
  String get lookAndFeelThemeColorsGroupChatSurfaces => 'Чат и съобщения';

  @override
  String get lookAndFeelThemeColorsGroupSidebars =>
      'Странични ленти и навигация';

  @override
  String get lookAndFeelThemeColorsGroupText => 'Текст';

  @override
  String get lookAndFeelThemeColorsGroupHeaders => 'Заглавни ленти';

  @override
  String get lookAndFeelThemeColorsGroupStatus => 'Състояние';

  @override
  String get lookAndFeelThemeColorsGroupEmbedsMarkup =>
      'Вграждания и споменавания';

  @override
  String get lookAndFeelThemeColorsGroupAccentsAlerts =>
      'Акценти и предупреждения';

  @override
  String get lookAndFeelThemeColorsGroupControls => 'Повърхности и контроли';

  @override
  String get lookAndFeelChatFontScalingTitle => 'Мащабиране на шрифта в чата';

  @override
  String get lookAndFeelChatFontScalingDescription =>
      'Настрой размера на шрифта в чата.';

  @override
  String get lookAndFeelChatFontSizeLabel => 'Размер на шрифта в чата';

  @override
  String get lookAndFeelAppZoomTitle => 'Мащаб на приложението';

  @override
  String get lookAndFeelAppZoomDescription =>
      'Настройте нивото на мащабиране на приложението.';

  @override
  String get lookAndFeelChatWallpaperTitle => 'Тапет на чата';

  @override
  String get lookAndFeelChatWallpaperDescription =>
      'Изберете фон за чата. Той ще остане на това устройство.';

  @override
  String get lookAndFeelChatWallpaperLocalOnlyTooltip =>
      'Тази настройка остава на това устройство';

  @override
  String get lookAndFeelChatWallpaperLocalOnlyToast =>
      'Тапетът за чат е запазен само на това устройство и не се синхронизира с други устройства.';

  @override
  String get lookAndFeelChatWallpaperDefaultLabel => 'По подразбиране';

  @override
  String get lookAndFeelChatWallpaperCustomLabel =>
      'Персонализирано изображение';

  @override
  String get lookAndFeelChatWallpaperStarfieldLabel => 'Звездно поле';

  @override
  String lookAndFeelChatWallpaperColorLabel(String id) {
    return 'Цвят $id';
  }

  @override
  String lookAndFeelChatWallpaperGradientLabel(String id) {
    return 'Градиент $id';
  }

  @override
  String get lookAndFeelChatWallpaperDimLabel => 'Затъмняване на тапета';

  @override
  String get lookAndFeelChatWallpaperPickFailed =>
      'Не можехме да зададем това изображение като тапет.';

  @override
  String get lookAndFeelMessagesSectionTitle => 'Съобщения';

  @override
  String get lookAndFeelMessagesSectionDescription =>
      'Изберете как да се показват съобщенията в чат каналите.';

  @override
  String get lookAndFeelMessageGroupSpacingLabel =>
      'Разстояние между групи съобщения';

  @override
  String lookAndFeelMessageGroupSpacingValue(int spacing) {
    return '${spacing}px';
  }

  @override
  String get lookAndFeelMessageDisplayModeLabel =>
      'Режим на показване на съобщенията';

  @override
  String get lookAndFeelMessageDisplayComfyName => 'Удобен';

  @override
  String get lookAndFeelMessageDisplayComfyDescription =>
      'Просторно оформление с ясна визуална разлика между съобщенията.';

  @override
  String get lookAndFeelMessageDisplayDenseName => 'Сбит';

  @override
  String get lookAndFeelMessageDisplayDenseDescription =>
      'Максимизира видимите съобщения с минимално разстояние.';

  @override
  String get lookAndFeelHideUserAvatarsLabel =>
      'Скрий аватарите на потребителите';

  @override
  String get lookAndFeelInterfaceTitle => 'Интерфейс';

  @override
  String get lookAndFeelInterfaceDescription =>
      'Персонализиране на елементи и поведение на интерфейса.';

  @override
  String get lookAndFeelChannelTypingIndicatorsTitle =>
      'Индикатори за писане в списъка с канали';

  @override
  String get lookAndFeelChannelTypingIndicatorsDescription =>
      'Изберете как да се показват индикаторите за писане в списъка с канали, когато някой пише в канал.';

  @override
  String get lookAndFeelChannelTypingIndicatorAvatarsName =>
      'Индикатор за писане + Аватари';

  @override
  String get lookAndFeelChannelTypingIndicatorAvatarsDescription =>
      'Показване на индикатор за писане с аватари на потребители в списъка с канали';

  @override
  String get lookAndFeelChannelTypingIndicatorOnlyName =>
      'Само индикатор за писане';

  @override
  String get lookAndFeelChannelTypingIndicatorOnlyDescription =>
      'Показване само на индикатора за писане без аватари';

  @override
  String get lookAndFeelChannelTypingIndicatorHiddenName => 'Скрито';

  @override
  String get lookAndFeelChannelTypingIndicatorHiddenDescription =>
      'Без индикатори за писане в списъка с канали';

  @override
  String get lookAndFeelShowSelectedChannelTypingIndicatorLabel =>
      'Показване на писане в избрания канал';

  @override
  String get lookAndFeelShowSelectedChannelTypingIndicatorDescription =>
      'Когато е изключено (по подразбиране), индикаторите за писане няма да се показват в канала, който в момента преглеждате.';

  @override
  String get lookAndFeelTypingIndicatorPreviewChannelName => 'общи';

  @override
  String get lookAndFeelKeyboardHintsTitle => 'Подсказки за клавиатурата';

  @override
  String get lookAndFeelKeyboardHintsDescription =>
      'Контролирайте дали подсказките за клавишни комбинации се показват в подсказки.';

  @override
  String get lookAndFeelHideKeyboardHintsLabel =>
      'Скрий подсказките за клавиатурата в подсказките';

  @override
  String get lookAndFeelHideKeyboardHintsDescription =>
      'Когато е включено, значките за преки пътища се скриват в изскачащи подсказки.';

  @override
  String get lookAndFeelGuildSidebarTitle => 'Лента на сървъра';

  @override
  String get lookAndFeelGuildSidebarDescription =>
      'Настройте как страничната лента на сървъра показва директни съобщения.';

  @override
  String guildUnavailableOutageTooltip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count общности временно не са достъпни поради неизправност на флукс кондензатора.',
      one:
          '1 общност временно не е достъпна поради неизправност на флукс кондензатора.',
    );
    return '$_temp0';
  }

  @override
  String get communityTemporarilyUnavailable => 'Общността временно недостъпна';

  @override
  String get guildUnavailableDescription =>
      'Нещо се обърка. Работим по въпроса.';

  @override
  String get guildNotFoundTitle => 'Това не е общността, която търсите.';

  @override
  String get guildNotFoundDescription =>
      'Общността, която търсите, може да е изтрита или да нямате достъп до нея.';

  @override
  String guildStaffOnlyAccessibleNagbar(
    String communityName,
    String productName,
  ) {
    return '$communityName в момента е достъпен само за служители на $productName';
  }

  @override
  String get guildNavbarTemporarilyUnavailable => 'временно недостъпно';

  @override
  String get lookAndFeelCollapseDMsLabel => 'Свий лични съобщения във папка';

  @override
  String lookAndFeelCollapseDMsDescription(String productName) {
    return 'Когато е активирано, непрочетените лични съобщения в страничната лента на сървъра се свиват в папка върху бутона $productName. Кликнете върху бутона $productName, докато сте на страницата за лични съобщения, за да разширите или свиете папката.';
  }

  @override
  String get lookAndFeelOpenCommunitiesToLastChannelLabel =>
      'Отваряне на общностите в последния канал';

  @override
  String get lookAndFeelOpenCommunitiesToLastChannelDescription =>
      'Докосването на общност те отвежда директно в последния канал, който си разглеждал там. Плъзни надясно, за да видиш списъка ѝ с канали.';

  @override
  String get lookAndFeelChannelListSectionTitle => 'Списък с канали';

  @override
  String get lookAndFeelChannelListSectionDescription =>
      'Управлявайте поведението на индикатора за непрочетени съобщения за заглушени канали в списъците с канали.';

  @override
  String get lookAndFeelShowFadedUnreadOnMutedChannelsLabel =>
      'Показване на индикатор за непрочетени съобщения в заглушени канали';

  @override
  String get lookAndFeelShowFadedUnreadOnMutedChannelsDescription =>
      'Когато е включено, заглушените канали показват бледо индикатор за непрочетени съобщения отляво. Споменаванията все още се показват независимо от тази настройка.';

  @override
  String get lookAndFeelActiveNowSectionTitle => 'Активни в момента';

  @override
  String get lookAndFeelActiveNowSectionDescription =>
      'Контролирайте как се показва \"Активен сега\" в приложението.';

  @override
  String get lookAndFeelShowActiveNowLabel =>
      'Покажи „Активни в момента“ на началния екран';

  @override
  String get lookAndFeelShowActiveNowDescription =>
      'Покажи активни в момента на началния екран, за да виждаш приятели, които са активни в гласови канали. Ще виждаш предварителен преглед, контекста на канала, кой вече е там и бърз начин да се присъединиш.';

  @override
  String get lookAndFeelFavoritesSectionTitle => 'Любими';

  @override
  String get lookAndFeelFavoritesSectionDescription =>
      'Контролирайте видимостта на любимите елементи в цялото приложение.';

  @override
  String get lookAndFeelEnableFavoritesLabel => 'Активиране на любими';

  @override
  String get lookAndFeelEnableFavoritesDescription =>
      'Когато е включено, можете да добавяте канали към любими и те ще се показват в секцията „Любими“. Когато е изключено, всички елементи на потребителския интерфейс, свързани с любими (бутони, елементи от менюто), ще бъдат скрити. Вашите съществуващи любими ще бъдат запазени.';

  @override
  String get favoritesTitle => 'Любими';

  @override
  String get favoritesEmptyTitle => 'Няма добавени в любими';

  @override
  String get favoritesEmptyDescription =>
      'Запазвайте каналите със звездичка от заглавката на чата, за да ги държите тук.';

  @override
  String get favoritesWelcomeTitle => 'Добре дошли в любими';

  @override
  String get favoritesWelcomeDescription =>
      'Вашето лично пространство за бърз достъп до любими канали, лични съобщения и групи. Натиснете звездата на всеки канал, за да го добавите тук.';

  @override
  String get favoritesWelcomeTip => 'Не е за вас? Изключете го по всяко време.';

  @override
  String get favoritesDisableButton => 'Изключване на любими';

  @override
  String get favoritesAddedToast => 'Добавено към любими';

  @override
  String get favoritesRemovedToast => 'Премахнато от Любими';

  @override
  String get favoritesHiddenToast => 'Любими скрити';

  @override
  String get favoritesMute => 'Заглуши любими';

  @override
  String get favoritesUnmute => 'Включване на любими';

  @override
  String get favoritesHeaderMenu => 'Меню с любими';

  @override
  String get favoritesCreateCategory => 'Създаване на категория';

  @override
  String get favoritesCategoryNameLabel => 'Име на категорията';

  @override
  String get favoritesHideMutedChannels => 'Скрий заглушените канали';

  @override
  String get favoritesShowMutedChannels => 'Показване на заглушени канали';

  @override
  String get favoritesSetNickname => 'Задай прякор';

  @override
  String get favoritesNicknameLabel => 'Псевдоним';

  @override
  String get favoritesSaveNickname => 'Запази прякор';

  @override
  String get favoritesMoveToCategory => 'Премести в категория';

  @override
  String get favoritesUncategorized => 'Без категория';

  @override
  String get favoritesOtherCategory => 'Друго';

  @override
  String get favoritesRemoveFromFavorites => 'Премахни от Любими';

  @override
  String get favoritesAddToFavorites => 'Добави към любими';

  @override
  String get favoritesAddToSavedMedia => 'Добавяне към запазени медии';

  @override
  String get favoritesRemoveFromSavedMedia => 'Премахване от запазените медии';

  @override
  String get favoritesAddToUrlOnlyGifFavorites =>
      'Добавяне към списък с любими GIF файлове, достъпни само по URL адрес';

  @override
  String get favoritesRemoveFromUrlOnlyGifFavorites =>
      'Премахване от любимите GIF файлове, запазени по URL адрес';

  @override
  String get savedMediaAddTitle => 'Добавяне към запазени медии';

  @override
  String get savedMediaFormNameLabel => 'Име';

  @override
  String get savedMediaFormNameHint => 'Моите страхотни медии';

  @override
  String get savedMediaFormAltTextLabel => 'Алт. текст';

  @override
  String get savedMediaFormAltTextHint => 'Опишете медията';

  @override
  String get savedMediaFormTagsLabel => 'Тагове';

  @override
  String get savedMediaFormTagsHint => 'забавно, реакция, работа';

  @override
  String get savedMediaSaveError =>
      'Не може да се актуализира запазеното съдържание.';

  @override
  String get savedMediaNameRequired => 'Името е задължително.';

  @override
  String get gifFavoriteFirstTimeTitle =>
      'Как да запазим любимите ти GIF файлове?';

  @override
  String get gifFavoriteFirstTimeDescription =>
      'Можете да запазвате любими GIF файлове като предпочитани само с URL адрес или да ги качвате в запазените си медийни файлове. Изберете това, което най-добре отговаря на начина, по който ги използвате. Можете да го промените по всяко време в Настройки > Разширени > Медия.';

  @override
  String get gifFavoriteFirstTimeUrlOnlyDetails =>
      'URL-само любими (по подразбиране): синхронизирани на всичките ви устройства, без качване, не се броят към запазените медии. Оригиналните медии може да изчезнат, ако хостът им ги премахне.';

  @override
  String get gifFavoriteFirstTimeSavedMediaDetails =>
      'Запазени медии: качени, с възможност за тагване, търсене и постоянни, но се броят към лимита ви за запазени медии.';

  @override
  String get gifFavoriteFirstTimeHint => 'Ще попитаме само веднъж.';

  @override
  String get gifFavoriteFirstTimeUseUrlOnly =>
      'Използвай само URL (препоръчително)';

  @override
  String get gifFavoriteFirstTimeUseSavedMedia => 'Използвай запазени медии';

  @override
  String get favoritesHideConfirmTitle => 'Скрий любими';

  @override
  String get favoritesHideConfirmDescription =>
      'Това ще скрие всички елементи на потребителския интерфейс, свързани с любими, включително бутони и елементи от менюто. Вашите съществуващи любими ще бъдат запазени и могат да бъдат активирани отново по всяко време от Настройки > Разширени > Външен вид.';

  @override
  String get favoritesDirectMessageSubtitle => 'Лично съобщение';

  @override
  String get messagesMediaDisplayGroupTitle => 'Показване';

  @override
  String get messagesMediaDisplayGroupDescription =>
      'Контролирайте как се показват съобщения, медии и друго съдържание.';

  @override
  String get messagesMediaMediaGroupTitle => 'Медия';

  @override
  String get messagesMediaMediaGroupDescription =>
      'Персонализирайте предпочитанията за размер на медиите и бутоните.';

  @override
  String get messagesMediaInputGroupTitle => 'Въвеждане';

  @override
  String get messagesMediaInputGroupDescription =>
      'Персонализирайте настройките за въвеждане на съобщения.';

  @override
  String get messagesMediaSidebarGroupTitle => 'Странична лента';

  @override
  String get messagesMediaSidebarGroupDescription =>
      'Настройте как се показва страничната лента на общността.';

  @override
  String get messagesMediaDefaultHideMutedChannelsLabel =>
      'Скрий заглушените канали по подразбиране';

  @override
  String get messagesMediaDefaultHideMutedChannelsDescription =>
      'Автоматично скриване на заглушените канали в страничната лента, когато се присъединявате към нови общности';

  @override
  String get messagesMediaDefaultHideMutedChannelsEnableTitle =>
      'Да се скриват ли заглушените канали по подразбиране?';

  @override
  String get messagesMediaDefaultHideMutedChannelsEnableDescription =>
      'Новите общности, към които се присъединявате, автоматично ще имат скрити заглушени канали. Искате ли да приложите тази настройка и към всичките си съществуващи общности?';

  @override
  String get messagesMediaDefaultHideMutedChannelsDisableTitle =>
      'Да спрем ли скриването на заглушени канали по подразбиране?';

  @override
  String get messagesMediaDefaultHideMutedChannelsDisableDescription =>
      'Новите общности, към които се присъединявате, вече няма да имат автоматично скрити заглушени канали. Искате ли също така да показвате заглушени канали във всичките си съществуващи общности?';

  @override
  String get messagesMediaDefaultHideMutedChannelsApplyAllAction =>
      'Приложи към всички общности';

  @override
  String get messagesMediaDefaultHideMutedChannelsShowAllAction =>
      'Показване във всички общности';

  @override
  String get messagesMediaDefaultHideMutedChannelsNewOnlyAction =>
      'Само нови общности';

  @override
  String get messagesMediaDisplaySectionTitle => 'Медия и показване';

  @override
  String get messagesMediaDisplaySectionDescription =>
      'Контролирайте как се показват изображения, видеоклипове и други медии. Всички медии се преоразмеряват и конвертират. Изключително големи файлове, които не могат да бъдат компресирани в визуализация, няма да бъдат вградени, независимо от тези настройки.';

  @override
  String get messagesMediaDisplayInlineEmbedLabel =>
      'Когато се публикуват като връзки към чат';

  @override
  String messagesMediaDisplayInlineAttachmentLabel(String productName) {
    return 'Когато е качено директно във $productName';
  }

  @override
  String get messagesMediaLinkPreviewsSectionTitle => 'Визуализации на връзки';

  @override
  String get messagesMediaLinkPreviewsSectionDescription =>
      'Контролирайте как се показват визуализациите на уеб връзките в чата';

  @override
  String get messagesMediaLinkPreviewsToggleLabel =>
      'Показване на вградени елементи и визуализация на връзки към уебсайтове';

  @override
  String get messagesMediaReactionsSectionTitle => 'Реакции';

  @override
  String get messagesMediaReactionsSectionDescription =>
      'Настройте реакции с емоджи към съобщенията';

  @override
  String get messagesMediaReactionsToggleLabel =>
      'Показване на реакции с емоджита върху съобщенията';

  @override
  String get messagesMediaSpoilersSectionTitle => 'Съдържание със спойлери';

  @override
  String get messagesMediaSpoilersSectionDescription =>
      'Контролирайте как се показват скрити съобщения';

  @override
  String get messagesMediaSpoilersRadioLabel =>
      'Покажи съдържанието на спойлера';

  @override
  String get messagesMediaSpoilersOnClickName => 'При докосване';

  @override
  String get messagesMediaSpoilersOnClickDescription =>
      'Показване на скрито съдържание при докосване';

  @override
  String get messagesMediaSpoilersIfModeratorName =>
      'В канали, които модерирам';

  @override
  String get messagesMediaSpoilersIfModeratorDescription =>
      'Винаги показвай съдържание със спойлер в канали, където имаш разрешението „Управление на съобщения“.';

  @override
  String get messagesMediaSpoilersAlwaysName => 'Винаги';

  @override
  String get messagesMediaSpoilersAlwaysDescription =>
      'Винаги показвай скрито съдържание';

  @override
  String get messagesMediaSizeSectionTitle =>
      'Предпочитания за размер на медията';

  @override
  String get messagesMediaSizeSectionDescription =>
      'Персонализирайте максималния размер за показване на вградени и прикачени медийни файлове. По-малките размери заемат по-малко място на екрана, докато по-големите показват повече детайли.';

  @override
  String get messagesMediaSizeEmbedLabel => 'Медия от връзки (вградени)';

  @override
  String get messagesMediaSizeAttachmentLabel => 'Качени прикачени файлове';

  @override
  String get messagesMediaSizeCompactName => 'Компактен (400x300)';

  @override
  String get messagesMediaSizeCompactDescription =>
      'По-малък размер на медията';

  @override
  String get messagesMediaSizeComfortableName => 'Удобен (550x400)';

  @override
  String get messagesMediaSizeComfortableDescription =>
      'По-голям размер на медиите с повече детайли';

  @override
  String get messagesMediaGifsSectionTitle => 'Поведение на GIF';

  @override
  String get messagesMediaGifsSectionDescription =>
      'Контролирайте как GIF файловете се вмъкват в чата';

  @override
  String get messagesMediaGifsAutoSendLabel =>
      'Автоматично изпращане на GIF файлове при избиране';

  @override
  String get messagesMediaCameraUploadsSectionTitle => 'Качване от камерата';

  @override
  String get messagesMediaCameraUploadsSectionDescription =>
      'Изберете дали снимките и видеоклиповете, направени с камерата в приложението, да се запазват на вашето устройство';

  @override
  String get messagesMediaCameraUploadsSaveToDeviceLabel =>
      'Запазване на устройството';

  @override
  String get messagesMediaAutocompleteSectionTitle =>
      'Автоматично довършване на изрази (автоматично довършване с двоеточие)';

  @override
  String get messagesMediaAutocompleteSectionDescription =>
      'Контролирайте какво се появява в автоматичното довършване на изрази, когато пишете двоеточие. Персонализирайте кои предложения се показват, за да отговарят на вашите предпочитания.';

  @override
  String get messagesMediaAutocompleteDefaultEmojisLabel =>
      'Показване на стандартни емоджита в автоматичното довършване на изрази';

  @override
  String get messagesMediaAutocompleteCustomEmojisLabel =>
      'Показване на персонализирани емоджита в автоматичното довършване на изрази';

  @override
  String get messagesMediaAutocompleteStickersLabel =>
      'Показване на стикери при автоматично довършване на изрази';

  @override
  String get messagesMediaAutocompleteSavedMediaLabel =>
      'Показване на запазени медии в предложенията за изразяване';

  @override
  String get accessibilitySaturationTitle => 'Наситеност';

  @override
  String get accessibilityVisualGroupTitle => 'Визуални';

  @override
  String get accessibilityAlwaysUnderlineLinksLabel =>
      'Винаги подчертавай връзките';

  @override
  String get accessibilityShowAltTextOnImagesLabel =>
      'Показване на алтернативен текст на изображенията';

  @override
  String get accessibilityShowAltTextOnImagesDescription =>
      'Показване на алтернативен текст под изображенията, когато е наличен.';

  @override
  String get accessibilityDimStrikethroughTextLabel =>
      'Заглушаване на зачеркнат текст';

  @override
  String get accessibilityDmMessagePreviewGroupTitle =>
      'Визуализация на съобщения в директни чатове';

  @override
  String get accessibilityDmMessagePreviewModeLabel =>
      'Режим за предварителен преглед на лично съобщение';

  @override
  String get accessibilityDmMessagePreviewAllName => 'Всички съобщения';

  @override
  String get accessibilityDmMessagePreviewAllDescription =>
      'Показване на визуализации на съобщения за всички DM разговори';

  @override
  String get accessibilityDmMessagePreviewUnreadOnlyName =>
      'Само непрочетени лични съобщения';

  @override
  String get accessibilityDmMessagePreviewUnreadOnlyDescription =>
      'Показвай визуализации на съобщения само за директни съобщения с непрочетени съобщения';

  @override
  String get accessibilityDmMessagePreviewNoneName => 'Няма';

  @override
  String get accessibilityDmMessagePreviewNoneDescription =>
      'Без визуализация на съобщения в списъка с лични чатове';

  @override
  String get accessibilityScreenReaderGroupTitle => 'Екранен четец';

  @override
  String accessibilityScreenReaderGroupDescription(String productName) {
    return 'Контролирайте как $productName работи с екранни четци.';
  }

  @override
  String get accessibilityScreenReaderAnnounceNewMessagesLabel =>
      'Обявяване на нови съобщения';

  @override
  String get accessibilityScreenReaderAnnounceNewMessagesDescription =>
      'Позволява на екранните четци да обявяват нови съобщения, когато пристигат в отворения канал. Звуците за известия не се променят.';

  @override
  String get accessibilityTtsGroupTitle => 'Текст към говор';

  @override
  String get accessibilityTtsGroupDescription =>
      'Изберете скорост за четене на текста.';

  @override
  String get accessibilityTtsSpeechPlaybackSpeedLabel =>
      'Скорост на възпроизвеждане на говор';

  @override
  String get accessibilityTtsPlaySampleLabel => 'Пусни примерен звук';

  @override
  String get accessibilityTtsSilenceSampleLabel => 'Без звук (проба)';

  @override
  String get accessibilityPreviewButtonLabel =>
      'Бутон за предварителен преглед';

  @override
  String accessibilityPreviewLinksMessage(String linkPreviewExampleUrl) {
    return 'Така изглеждат връзките: $linkPreviewExampleUrl';
  }

  @override
  String get accessibilityPreviewUserName => 'Предварителен потребител';

  @override
  String get accessibilityKeyboardGroupTitle => 'Клавиатура';

  @override
  String get accessibilityShowTextareaFocusRingLabel =>
      'Показване на рамка за фокус върху текстовото поле за чат';

  @override
  String get accessibilityEscapeExitsKeyboardModeLabel =>
      'Клавишът Esc излиза от режима на клавиатурата';

  @override
  String get accessibilityShowContextMenuShortcutsLabel =>
      'Показване на преки пътища за контекстно меню';

  @override
  String get accessibilityConfirmBeforeStartingCallsLabel =>
      'Потвърждаване преди започване на разговори';

  @override
  String get accessibilityAnimationGroupTitle => 'Анимация';

  @override
  String get accessibilityReducedMotionActiveNote =>
      'Намаленото движение е включено, така че анимациите на съдържанието са поставени на пауза по подразбиране. Все още можете да включите всяка от тях, за да продължи да се възпроизвежда.';

  @override
  String get accessibilityPlayAnimatedEmojisLabel =>
      'Пускане на анимирани емоджита';

  @override
  String get accessibilityAutoPlayGifsMobileLabel =>
      'Автоматично възпроизвеждане на GIF файлове';

  @override
  String accessibilityAutoPlayGifsDesktopLabel(String productName) {
    return 'Автоматично възпроизвеждане на GIF файлове, когато $productName е на фокус';
  }

  @override
  String get accessibilityPlayingDespiteReducedMotion =>
      'Възпроизвежда се въпреки намаленото движение.';

  @override
  String get accessibilityPausedEmojiByReducedMotion =>
      'Поставено на пауза поради намалено движение. Включете, за да продължите възпроизвеждането на анимирани емотикони.';

  @override
  String get accessibilityPausedGifByReducedMotion =>
      'Поставено на пауза поради намалено движение. Включете, за да продължат да се възпроизвеждат GIF файлове.';

  @override
  String get accessibilityStickerAnimationsTitle => 'Анимации на стикери';

  @override
  String get accessibilityStickerAnimationPreferenceLabel =>
      'Предпочитания за анимация на стикери';

  @override
  String get accessibilityStickerAlwaysAnimateName => 'Винаги анимирай';

  @override
  String get accessibilityStickerAlwaysAnimateDescription =>
      'Стикерите винаги ще се анимират';

  @override
  String get accessibilityStickerAnimateOnInteractionName =>
      'Анимиране при взаимодействие';

  @override
  String get accessibilityStickerAnimateOnPressDescription =>
      'Стикерите ще се анимират, когато ги натиснете';

  @override
  String get accessibilityStickerAnimateOnHoverDescription =>
      'Стикерите ще се анимират, когато ги посочите или взаимодействате с тях';

  @override
  String get accessibilityStickerNeverAnimateName => 'Никога не анимирай';

  @override
  String get accessibilityStickerNeverAnimateDescription =>
      'Стикерите никога няма да се анимират';

  @override
  String get accessibilityStickersAlwaysDespiteReducedMotion =>
      'Винаги анимиране въпреки намаленото движение.';

  @override
  String get accessibilityStickersReducedMotionHint =>
      'Намаленото движение ограничава стикерите да анимират при взаимодействие. Изберете „винаги анимиране“, за да отмените.';

  @override
  String get accessibilityStickersDefaultsOnMobile =>
      'По подразбиране анимациите се възпроизвеждат при взаимодействие на мобилни устройства, за да се пести батерия.';

  @override
  String get accessibilityMotionGroupTitle => 'Движение';

  @override
  String get accessibilitySyncReducedMotionWithSystemLabel =>
      'Синхронизиране на намаленото движение със системата';

  @override
  String get accessibilitySyncReducedMotionWithSystemDescription =>
      'Използвайте системната настройка за намалено движение на това устройство или я персонализирайте по-долу.';

  @override
  String get accessibilityReducedMotionOverrideLabel =>
      'Намаляване на движението';

  @override
  String get accessibilityReducedMotionOverrideSyncedDescription =>
      'Деактивирайте анимациите и преходите. В момента се контролира от системните ви настройки.';

  @override
  String get accessibilityReducedMotionOverrideManualDescription =>
      'Деактивиране на анимациите и преходите в цялото приложение.';

  @override
  String get accessibilityReducedMotionAnimationTabHint =>
      'Анимираните емоджита, GIF файлове и стикери остават под ваш контрол в раздела „Анимация“.';

  @override
  String get accessibilityConfirmStartCallTitle => 'Започване на обаждане?';

  @override
  String get accessibilityConfirmStartCallDescription =>
      'Сигурни ли сте, че искате да започнете това обаждане?';

  @override
  String get accessibilityConfirmStartCallConfirmLabel =>
      'Започване на разговор';

  @override
  String get accessibilityTtsSampleDescription =>
      'Чуйте примерния ред, изговорен с избраната от вас скорост.';

  @override
  String get accessibilityTtsSampleText =>
      'Док, аз съм от бъдещето. Дойдох тук с машина на времето, която ти изобрети. Сега ми трябва помощта ти, за да се върна в 1985 г.';

  @override
  String get accessibilityTtsUnsupportedDescription =>
      'Синтезът на реч е недостъпен на това устройство.';

  @override
  String get accessibilityTtsPlaybackFailedDescription =>
      'Възпроизвеждането на говор е неуспешно. Опитайте отново или проверете дали аудиоизходът работи.';

  @override
  String get ttsSubstitutionUnknownUser => 'неизвестен потребител';

  @override
  String get ttsSubstitutionUnknownRole => 'неизвестна роля';

  @override
  String get ttsSubstitutionUnknownChannel => 'неизвестен канал';

  @override
  String get ttsSubstitutionCodeBlock => 'кодов блок';

  @override
  String get ttsSubstitutionSpoiler => 'спойлер';

  @override
  String ttsSubstitutionEmoji(String emojiName) {
    return 'емоджи $emojiName';
  }

  @override
  String ttsSubstitutionSlashCommand(String commandName) {
    return 'наклонена черта $commandName';
  }

  @override
  String ttsAuthorSaid(String authorName, String formatted) {
    return '$authorName каза: $formatted';
  }

  @override
  String ttsReplyingToSaid(
    String replyAuthorName,
    String authorName,
    String formatted,
  ) {
    return 'В отговор на $replyAuthorName, $authorName каза: $formatted';
  }

  @override
  String ttsAuthorDescription(String authorName, String description) {
    return '$authorName $description';
  }

  @override
  String get ttsSentSticker => 'изпрати стикер';

  @override
  String get ttsSentAttachment => 'изпрати прикачен файл';

  @override
  String ttsSentAttachments(int count) {
    return 'изпратени $count прикачени файла';
  }

  @override
  String get ttsSentEmbed => 'изпрати вградено съдържание';

  @override
  String messageScreenReaderAnnouncement(String author, String summary) {
    return '$author изпрати $summary';
  }

  @override
  String get dmListSentAnAttachment => 'Изпрати прикачен файл';

  @override
  String systemPreviewPinnedMessage(String username) {
    return '$username закачи съобщение в този канал.';
  }

  @override
  String systemPreviewAddedToGroup(String username, String userName) {
    return '$username добави $userName към групата.';
  }

  @override
  String systemPreviewAddedSomeoneToGroup(String username) {
    return '$username добави някого в групата.';
  }

  @override
  String systemPreviewHasLeftGroup(String username) {
    return '$username напусна групата.';
  }

  @override
  String systemPreviewRemovedFromGroup(String username, String userName) {
    return '$username премахна $userName от групата.';
  }

  @override
  String systemPreviewRemovedSomeoneFromGroup(String username) {
    return '$username премахна някого от групата.';
  }

  @override
  String systemPreviewChangedChannelNameTo(String username, String newName) {
    return '$username промени името на канала на $newName.';
  }

  @override
  String systemPreviewChangedChannelName(String username) {
    return '$username промени името на канала.';
  }

  @override
  String systemPreviewChangedChannelIcon(String username) {
    return '$username смени иконата на канала.';
  }

  @override
  String systemPreviewStartedCall(String username) {
    return '$username започна разговор.';
  }

  @override
  String get systemCallJoinTheCall => 'Присъединяване към разговора';

  @override
  String systemCallStartedThatLasted(String username, String duration) {
    return '$username започна разговор, който продължи $duration.';
  }

  @override
  String systemCallMissedWithDuration(String username, String duration) {
    return 'Пропуснахте обаждане от $username, което продължи $duration.';
  }

  @override
  String systemCallMissed(String username) {
    return 'Пропуснахте обаждане от $username.';
  }

  @override
  String get systemCallDurationFewSeconds => 'преди секунди';

  @override
  String get systemCallDurationMinute => 'една минута';

  @override
  String get systemCallDurationOneYear => '1 година';

  @override
  String get systemCallDurationOneMonth => '1 месец';

  @override
  String get systemCallDurationOneWeek => '1 седмица';

  @override
  String get systemCallDurationOneDay => '1 ден';

  @override
  String get systemCallDurationOneHour => '1 час';

  @override
  String systemCallDurationYears(int count) {
    return '$count години';
  }

  @override
  String systemCallDurationMonths(int count) {
    return '$count месеца';
  }

  @override
  String systemCallDurationWeeks(int count) {
    return '$count седмици';
  }

  @override
  String systemCallDurationDays(int count) {
    return '$count дни';
  }

  @override
  String systemCallDurationHours(int count) {
    return '$count часа';
  }

  @override
  String systemCallDurationMinutes(int count) {
    return '$count минути';
  }

  @override
  String systemUnknownMessage(String productName) {
    return 'Актуализирайте $productName, за да видите това съобщение.';
  }

  @override
  String get voiceConnectionConfirmTitle => 'Потвърждение за гласова връзка';

  @override
  String voiceConnectionConfirmDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Вече сте свързани към този гласов канал от $count други устройства. Какво искате да направите?',
      one:
          'Вече сте свързани към този гласов канал от 1 друго устройство. Какво искате да направите?',
    );
    return '$_temp0';
  }

  @override
  String get voiceConnectionConfirmSwitch => 'Прехвърляне към това устройство';

  @override
  String get voiceConnectionConfirmJustJoin =>
      'Присъедини се (запази други връзки)';

  @override
  String get voiceConnectionConfirmDoNothing =>
      'Не, не искам да се присъединявам';

  @override
  String get voiceJoinFailedTitle =>
      'Не успях да се присъединя към гласовото повикване';

  @override
  String get voiceMultiDeviceDisconnectFailed =>
      'Не успяхме да прекъснем връзката с другите ви устройства. Опитайте отново след малко.';

  @override
  String get voiceChannelJoin => 'Присъединяване към гласов канал';

  @override
  String get voiceCallJoin => 'Присъединяване към разговора';

  @override
  String get voiceChannelJoinConnect => 'Свързване към гласово';

  @override
  String get voiceChannelNoConnectPermission =>
      'Нямате разрешение да се присъедините към този гласов канал';

  @override
  String get voiceChannelE2eeEncrypted =>
      'Микрофонът, камерата и съдържанието на споделения екран са криптирани от край до край.';

  @override
  String get voiceCallE2eeEncrypted =>
      'Микрофонът, камерата и съдържанието на споделения екран са криптирани от край до край.';

  @override
  String get voiceChannelE2eeBroken =>
      'Криптирането от край до край е недостъпно, защото в този гласов канал има неподдържан участник.';

  @override
  String get voiceCallE2eeBroken =>
      'Криптирането от край до край не е налично, тъй като в разговора участва неподдържан участник.';

  @override
  String get voiceE2eeUpdateRequired =>
      'Този клиент трябва да бъде актуализиран, преди да се присъедините към този криптиран разговор.';

  @override
  String get voiceMicPublishFailedStayConnected =>
      'Не успяхме да стартираме микрофона ви. Все още сте в разговора.';

  @override
  String get voiceChannelStatusConnecting => 'Свързване…';

  @override
  String get voiceParticipantTooltipMobileDevice => 'Мобилно устройство';

  @override
  String get voiceParticipantTooltipDesktopDevice => 'Настолно устройство';

  @override
  String get voiceParticipantTooltipCommunityMuted => 'Общността заглуши';

  @override
  String get voiceParticipantTooltipMuted => 'Изключен звук';

  @override
  String get voiceParticipantTooltipCommunityDeafened =>
      'Заглушен от общността';

  @override
  String get voiceParticipantTooltipDeafened => 'Без звук';

  @override
  String voiceParticipantTooltipConnection(String connectionId) {
    return 'Връзка: $connectionId';
  }

  @override
  String voiceChannelParticipantCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count участници',
      one: '1 участник',
    );
    return '$_temp0';
  }

  @override
  String get voiceChannelLeave => 'Напускане';

  @override
  String get voiceControlMute => 'Заглуши';

  @override
  String get voiceControlUnmute => 'Включване на звука';

  @override
  String get voiceControlDeafen => 'Изключване на звука';

  @override
  String get voiceControlUndeafen => 'Включване на звука';

  @override
  String get voiceControlVideo => 'Видео';

  @override
  String get voiceControlFlipCamera => 'Превключване на камерата';

  @override
  String get voiceControlScreenShare => 'Споделяне на екран';

  @override
  String get voiceScreenShareNotificationText => 'Споделяне на екрана ви.';

  @override
  String get voiceControlDisconnect => 'Прекъсване';

  @override
  String get voiceInChat => 'В гласов чат';

  @override
  String get voiceConnectionFailed => 'Връзката е прекъсната';

  @override
  String get voiceConnectionRetry => 'Опитай пак';

  @override
  String get voiceConnectionDismiss => 'Затвори';

  @override
  String get voiceConnectionDisconnected => 'Прекъснато';

  @override
  String voicePingMs(int currentLatency) {
    return 'Пинг: ${currentLatency}ms';
  }

  @override
  String get voiceMeasuringLatency => 'Измерване на латентност...';

  @override
  String voiceJumpToChannel(String channelSourceLabel) {
    return 'Отиване до $channelSourceLabel';
  }

  @override
  String get shellResizeSidebar => 'Преоразмеряване на страничната лента';

  @override
  String get voiceConnectionTitle => 'Гласова връзка';

  @override
  String get voiceConnectionAdvancedStats => 'Разширени';

  @override
  String get voiceShowCallAvatars => 'Покажи аватари на повикванията';

  @override
  String get voiceShowConnectionId => 'Покажи ID на връзката';

  @override
  String get voiceAudioProcessing => 'Обработка на аудио';

  @override
  String get voiceConnectionSessionSection => 'Сесия';

  @override
  String get voiceConnectionDurationLabel => 'Продължителност';

  @override
  String get voiceConnectionParticipantsLabel => 'Участници';

  @override
  String get voiceConnectionNetworkSection => 'Мрежа';

  @override
  String get voiceConnectionPingLabel => 'Изпрати пинг';

  @override
  String get voiceConnectionJitterLabel => 'Трептене';

  @override
  String get voiceConnectionSendLabel => 'Изпращане';

  @override
  String get voiceConnectionReceiveLabel => 'Получаване';

  @override
  String get voiceConnectionUnavailable => '—';

  @override
  String voiceConnectionDuration(int minutes, int seconds) {
    return '$minutesм $secondsс';
  }

  @override
  String voiceConnectionLatencyMs(int latency) {
    return '$latency мс';
  }

  @override
  String voiceConnectionJitterMs(String jitter) {
    return '$jitter мс';
  }

  @override
  String voiceConnectionBandwidthKbps(String bandwidth) {
    return '$bandwidth кбит/с';
  }

  @override
  String get userAreaMuteMicrophone => 'Изключване на микрофона';

  @override
  String get userAreaUnmuteMicrophone => 'Включване на микрофона';

  @override
  String get userAreaUserSettings => 'Потребителски настройки';

  @override
  String get voiceParticipantMenuViewProfile => 'Преглед на профил';

  @override
  String get voiceParticipantMenuFocus => 'Фокусирай този човек';

  @override
  String get voiceParticipantMenuUnfocus => 'Отмени фокуса';

  @override
  String get voiceParticipantMenuCommunityMute =>
      'Изключване на звука в общността';

  @override
  String get voiceParticipantMenuCommunityDeafen => 'Заглушаване в общността';

  @override
  String get voiceParticipantMenuUserVolume => 'Сила на звука на потребителя';

  @override
  String get voiceParticipantMenuStreamVolume => 'Сила на звука на стрийма';

  @override
  String get voiceParticipantMenuStopStreaming => 'Спиране на стрийминг';

  @override
  String get voiceControlChat => 'Чат';

  @override
  String get voiceCallViewModeLabel => 'Преглед';

  @override
  String get voiceCallViewModeGrid => 'Решетка';

  @override
  String get voiceCallViewModeFocus => 'Фокус';

  @override
  String get voicePanelSettingsSectionTitle => 'Настройки на гласа';

  @override
  String get voicePanelUseEarpieceLabel => 'Използвай слушалката';

  @override
  String get voiceOutputRouteSpeaker => 'Високоговорител';

  @override
  String get voiceOutputRouteEarpiece => 'Слушалка';

  @override
  String get voiceOutputRouteHeadset => 'Слушалки';

  @override
  String get voiceChangeAudioOutputLabel => 'Change audio output';

  @override
  String get voicePanelOnlyShowVideosLabel => 'Показвай само видеа';

  @override
  String get voicePanelOnlyShowVideosDescription =>
      'Показвай само участници с включена камера.';

  @override
  String get voicePanelShowOwnCameraLabel => 'Покажи моята камера';

  @override
  String get voicePrioritizeSpeakersLabel => 'Приоритизиране на говорещите';

  @override
  String get voiceTextChatShow => 'Покажи чата';

  @override
  String voiceTextChatShowUnread(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count непрочетени съобщения',
      one: '$count непрочетено съобщение',
    );
    return 'Покажи чата с $_temp0';
  }

  @override
  String get voiceCameraPermissionRequired =>
      'Необходим е достъп до камерата за видео.';

  @override
  String get voiceErrorScreenShareToggle =>
      'Не успяхме да стартираме споделянето на екрана. Моля, опитайте отново.';

  @override
  String get voiceErrorScreenSharePermissionDenied =>
      'Разрешението за споделяне на екрана беше отказано.';

  @override
  String get voiceErrorScreenShareUnsupported =>
      'Споделянето на екран не е налично на това устройство.';

  @override
  String get voiceWatchStream => 'Гледай потока';

  @override
  String get voiceStopWatching => 'Спиране на гледането';

  @override
  String get voiceStopWatchingCurrentStreamTooltip =>
      'Спиране на гледането на текущия поток';

  @override
  String get voiceScreenShareEnterFullscreenTooltip => 'Цял екран';

  @override
  String get voiceScreenShareExitFullscreenTooltip => 'Изход от цял екран';

  @override
  String voiceVideoZoomLevel(String scale) {
    return 'Zoom $scale';
  }

  @override
  String get voiceOwnScreenShareTitle => 'Излъчвате';

  @override
  String get voiceOwnScreenShareSubtitle =>
      'Вашият стрийм е на живо за участниците.';

  @override
  String get voiceLiveBadge => 'На живо';

  @override
  String get dmVoiceViewCall => 'Преглед на обаждането';

  @override
  String get dmVoiceCallFullScreen => 'Цял екран';

  @override
  String get dmVoiceCallFullScreenTooltip => 'Отвори разговора на цял екран';

  @override
  String get dmVoiceStripStatusConnecting => 'Свързване…';

  @override
  String get dmVoiceStripStatusInCall => 'В разговор';

  @override
  String get dmVoiceEmbeddedFallbackTitle => 'Гласово повикване';

  @override
  String get dmVoiceCallBarConnecting => 'Свързване…';

  @override
  String get dmVoiceCallBarDirectPrimary => 'Директно повикване';

  @override
  String get dmVoiceCallBarGroupPrimary => 'Групово обаждане';

  @override
  String get dmVoiceCallBarIssueFallback => 'Проблем с гласа';

  @override
  String get dmVoiceFullscreenTitle => 'Гласово';

  @override
  String get voiceCallBarGuildConnectedFallback => 'Гласово свързване';

  @override
  String get notificationsPageTitle => 'Известия';

  @override
  String get notificationsFilterUnreads => 'Непрочетени';

  @override
  String get notificationsFilterMentions => 'Споменавания';

  @override
  String get notificationsBookmarksTooltip => 'Отметки';

  @override
  String get notificationsMentionFilterTooltip => 'Филтриране на споменавания';

  @override
  String get notificationsMentionFiltersTitle => 'Филтри за споменавания';

  @override
  String get notificationsMentionIncludeEveryone =>
      'Включи споменаванията @everyone и @here';

  @override
  String get notificationsMentionIncludeRoles =>
      'Включване на споменавания на роли';

  @override
  String get notificationsMentionIncludeGuilds =>
      'Включване на всички споменавания в общността';

  @override
  String get notificationsNoUnreadTitle => 'Няма непрочетени съобщения';

  @override
  String get notificationsNoUnreadBody => 'Всичко е прегледано.';

  @override
  String get notificationsNoMentionsTitle => 'Няма скорошни споменавания';

  @override
  String get notificationsNoMentionsBody =>
      'Всички @споменавания на теб ще се показват тук за 7 дни.';

  @override
  String get notificationsMentionsEndTitle => 'Достигнахте края';

  @override
  String get notificationsMentionsEndBody =>
      'Видял си всичките си скорошни споменавания. Не се тревожи, скоро ще се появят още.';

  @override
  String get notificationsJump => 'Премини';

  @override
  String get notificationsRemoveMentionTooltip => 'Премахване на споменаване';

  @override
  String get notificationsViewAllUnread => 'Преглед на всички непрочетени';

  @override
  String get notificationsMarkAsRead => 'Отбелязване като прочетено';

  @override
  String get notificationsExpand => 'Разгъване';

  @override
  String get notificationsCollapse => 'Свиване';

  @override
  String get notificationsMessageUnavailable =>
      'Това съобщение не може да бъде заредено.';

  @override
  String notificationsMentionedYouIn(String author, String place) {
    return '$author те спомена в $place:';
  }

  @override
  String notificationsRepliedToYouIn(String author, String place) {
    return '$author ти отговори в $place:';
  }

  @override
  String notificationsMentionedYou(String author) {
    return '$author те спомена:';
  }

  @override
  String notificationsRepliedToYou(String author) {
    return '$author ти отговори:';
  }

  @override
  String notificationsMentionPlace(String server, String channel) {
    return '$server – $channel';
  }

  @override
  String get notificationsSendReply => 'Изпрати отговор';

  @override
  String get notificationsRecentActivity => 'Скорошна активност';

  @override
  String get notificationsRemoveNotification => 'Премахване на известието';

  @override
  String characterCounterRemaining(int remaining) {
    return 'Остават още $remaining знака';
  }

  @override
  String get characterCounterTooLong => 'Съобщението е твърде дълго';

  @override
  String characterCounterRemainingPlutoniumUpsell(
    int remaining,
    String productName,
    int premiumMaxLength,
  ) {
    return '$remaining символа остават. Вземете $productName, за да пишете до $premiumMaxLength символа.';
  }

  @override
  String get chatMessageFailedToSend => 'Неуспешно изпращане на съобщение';

  @override
  String get chatMessageFailedToSendTapForOptions =>
      'Неуспешно изпращане на съобщение. Докоснете за опции.';

  @override
  String chatSendFailureDmRestricted(String settingsPath) {
    return 'Съобщението ви не може да бъде доставено. Обикновено това е така, защото не споделяте общност с получателя или получателя приема директни съобщения само от приятели. Може също да се наложи да коригирате собствените си настройки за поверителност на директните съобщения в $settingsPath.';
  }

  @override
  String get chatSendFailureUnclaimedDm =>
      'Съобщението ви не можа да бъде изпратено. Трябва да потвърдите профила си, за да изпращате директни съобщения.';

  @override
  String get chatSendFailureUnclaimedGeneral =>
      'Съобщението ви не можа да бъде изпратено. Трябва да потвърдите профила си, за да изпращате съобщения.';

  @override
  String get chatSendFailureContentBlocked =>
      'Съобщението ви не можа да бъде доставено, защото беше отбелязано от нашите системи за безопасност. Ако смятате, че това е грешка, моля, свържете се с поддръжката.';

  @override
  String get chatSendFailureContentBlockedSelfHosted =>
      'Съобщението ти не можа да бъде доставено, защото беше отбелязано от системите ни за безопасност. Ако смяташ, че това е грешка, свържи се с администраторите на тази инстанция.';

  @override
  String get chatSendFailureNsfwEmojiSticker =>
      'Съобщението ви не може да бъде доставено, защото съдържа неподходящи емотикони или стикери, които не са разрешени в този контекст.';

  @override
  String get chatClientSystemOnlyYouCanSee =>
      'Само вие можете да видите това съобщение.';

  @override
  String get chatClientSystemDismiss => 'Скрий';

  @override
  String get privacyDashboardCommunicationSection => 'Комуникация';

  @override
  String get privacyDashboardProfilePrivacySection =>
      'Поверителност на профила';

  @override
  String get privacyDashboardFriendsAndDirectMessagesSection =>
      'Приятели и директни съобщения';

  @override
  String get privacyDashboardActivitySharingSection => 'Споделяне на активност';

  @override
  String get privacyDashboardSensitiveContentSection =>
      'Чувствително съдържание';

  @override
  String get privacyDashboardDataExportSection => 'Експорт на данни';

  @override
  String get privacyDashboardDataDeletionSection => 'Изтриване на данни';

  @override
  String get privacyDashboardProfilePrivacyTitle =>
      'Кой може да вижда пълния ви профил';

  @override
  String get privacyDashboardProfilePrivacyAllCommunities =>
      'Приятели и всички общности';

  @override
  String get privacyDashboardProfilePrivacyAllCommunitiesDesc =>
      'Пълният ви профил е видим за приятели и за всеки във вашите общности';

  @override
  String get privacyDashboardProfilePrivacySmallCommunities =>
      'Само приятели и малки общности';

  @override
  String get privacyDashboardProfilePrivacySmallCommunitiesDesc =>
      'Пълният ви профил е видим за приятели и членове на общностите ви с 200 или по-малко членове';

  @override
  String get privacyDashboardProfilePrivacyFriendsOnly => 'Само приятели';

  @override
  String get privacyDashboardProfilePrivacyFriendsOnlyDesc =>
      'Пълният ви профил е видим само за вашите приятели';

  @override
  String get privacyDashboardFriendRequestsTitle => 'Заявки за приятелство';

  @override
  String get privacyDashboardFriendRequestsEveryone => 'Всеки';

  @override
  String get privacyDashboardFriendRequestsFriendsOfFriends =>
      'Приятели на приятели';

  @override
  String get privacyDashboardFriendRequestsCommunityMembers =>
      'Членове на общността';

  @override
  String get privacyDashboardDirectMessagesTitle => 'Директни съобщения';

  @override
  String get privacyDashboardDirectMessagesMembers =>
      'Разрешаване на директни съобщения от членове на общността';

  @override
  String get privacyDashboardDirectMessagesBots =>
      'Разрешаване на директни съобщения от ботове на общността';

  @override
  String get privacyDashboardIncomingCallsTitle => 'Входящи повиквания';

  @override
  String get privacyDashboardAllowedCallers => 'Разрешени обаждащи се';

  @override
  String get privacyDashboardIncomingCallNobodyDesc =>
      'Блокирай всички входящи повиквания';

  @override
  String get privacyDashboardIncomingCallFriendsOnlyDesc =>
      'Позволи само на приятели да ти се обаждат (препоръчително)';

  @override
  String get privacyDashboardIncomingCallCustomDesc =>
      'Позволи на приятели плюс допълнителни групи, които избереш';

  @override
  String get privacyDashboardIncomingCallEveryoneDesc =>
      'Позволете на всеки да ви се обажда, дори непознати';

  @override
  String get privacyDashboardAdditionalGroups => 'Допълнителни групи';

  @override
  String get privacyDashboardRingBehavior => 'Поведение на пръстена';

  @override
  String get privacyDashboardSilentCalls => 'Безшумни повиквания от всички';

  @override
  String get privacyDashboardGroupDmTitle =>
      'Кой може да ви добавя в групови чатове';

  @override
  String get privacyDashboardAllowedInvites => 'Разрешени покани';

  @override
  String get privacyDashboardGroupDmNobodyDesc =>
      'Никой да не може да те добавя в групови чатове без твое разрешение';

  @override
  String get privacyDashboardGroupDmFriendsOnlyDesc =>
      'Позволи само на приятели да те добавят без потвърждение (препоръчително)';

  @override
  String get privacyDashboardGroupDmCustomDesc =>
      'Позволи на приятели плюс допълнителни групи да те добавят';

  @override
  String get privacyDashboardGroupDmEveryoneDesc =>
      'Позволете на всеки да ви добавя в групови чатове без запитване';

  @override
  String get privacyDashboardVoiceActivityTitle =>
      'Гласова активност в „Активен сега\"';

  @override
  String get privacyDashboardShareVoiceActivity =>
      'Споделяне на гласовата ви активност с приятели';

  @override
  String get privacyDashboardVoiceActivityEnableTitle =>
      'Да споделяте гласова активност с всички приятели?';

  @override
  String get privacyDashboardVoiceActivityDisableTitle =>
      'Да спрете ли споделянето на гласова активност с всички приятели?';

  @override
  String get privacyDashboardVoiceActivityEnableDesc =>
      'Предстои да започнете да споделяте гласовата си активност с всичките си приятели, включително бъдещите. Това изпраща актуализация до всички тях и може да бъде променено отново едва след 24 часа.';

  @override
  String get privacyDashboardVoiceActivityDisableDesc =>
      'Предстои да спрете да споделяте гласовата си активност с всичките си приятели, включително бъдещите. Това изпраща актуализация до всички тях и може да бъде променено отново едва след 24 часа.';

  @override
  String get privacyDashboardVoiceActivityEnableConfirm =>
      'Да, сподели с всички приятели';

  @override
  String get privacyDashboardVoiceActivityDisableConfirm =>
      'Да, спри споделянето';

  @override
  String privacyDashboardVoiceActivityCooldown(String time) {
    return 'Налично отново след $time';
  }

  @override
  String get privacyDashboardVoiceActivityUpdated =>
      'Споделянето на гласова активност е актуализирано';

  @override
  String get privacyDashboardVoiceActivityUpdateFailed =>
      'Не може да се актуализира споделянето на гласова активност в момента';

  @override
  String get privacyDashboardDataExportDesc =>
      'Създайте архив за изтегляне на данните от профила си, включително съобщения и URL адреси на прикачени файлове. Повечето хора искат всичко, но можете да стесните обхвата по-долу.';

  @override
  String get privacyDashboardExportMyData => 'Експортиране на моите данни';

  @override
  String get privacyDashboardDataDeletionDesc =>
      'Завинаги премахване на съобщения, които сте изпратили в директни съобщения, групови директни съобщения и общности. Процесът протича във фонов режим и ще получите директно съобщение, когато приключи.';

  @override
  String get privacyDashboardDeleteMyMessages => 'Изтриване на моите съобщения';

  @override
  String get privacyDashboardDmConfirmAllowMembersTitle =>
      'Разрешаване на директни съобщения от членове на общността?';

  @override
  String get privacyDashboardDmConfirmBlockMembersTitle =>
      'Блокиране на директни съобщения от членове на общността?';

  @override
  String get privacyDashboardDmConfirmAllowBotsTitle =>
      'Разрешаване на ботове да ви изпращат директни съобщения?';

  @override
  String get privacyDashboardDmConfirmBlockBotsTitle =>
      'Да блокирам ли ботове да ми изпращат директни съобщения?';

  @override
  String get privacyDashboardDmConfirmAllowMembersDesc =>
      'Искате ли да разрешите директни съобщения и от членове на съществуващите ви общности?';

  @override
  String get privacyDashboardDmConfirmBlockMembersDesc =>
      'Искате ли също да блокирате директни съобщения от членове на съществуващите ви общности?';

  @override
  String get privacyDashboardDmConfirmAllowBotsDesc =>
      'Искате ли ботове от съществуващите ви общности също да могат да ви изпращат директни съобщения?';

  @override
  String get privacyDashboardDmConfirmBlockBotsDesc =>
      'Искате ли да блокирате ботове и от съществуващите си общности?';

  @override
  String get privacyDashboardDmConfirmPerCommunityHint =>
      'Можете да промените тази настройка и за всяка общност, като натиснете продължително върху името на общността и изберете Настройки за поверителност.';

  @override
  String get privacyDashboardDmConfirmAllowAll =>
      'Разрешаване за всички общности';

  @override
  String get privacyDashboardDmConfirmBlockAll =>
      'Блокиране за всички общности';

  @override
  String get privacyDashboardDmConfirmSkip => 'Пропусни тази стъпка';

  @override
  String get privacyDashboardDataRequestGoBack => 'Назад';

  @override
  String get privacyDashboardDataRequestExportTitle =>
      'Експортиране на моите данни';

  @override
  String get privacyDashboardDataRequestDeleteTitle =>
      'Изтриване на моите съобщения';

  @override
  String get privacyDashboardDataRequestExportSuccess =>
      'Ще обработим заявката възможно най-скоро. Ще получите имейл, когато архивът ви е готов.';

  @override
  String get privacyDashboardDataRequestDeleteSuccess =>
      'Ще обработим това възможно най-скоро. Ще получите лично съобщение от нас, когато е готово.';

  @override
  String get privacyDashboardDataRequestScopeTitle => 'Какво да включите';

  @override
  String get privacyDashboardDataRequestExportEverything => 'Всичко';

  @override
  String get privacyDashboardDataRequestExportEverythingDesc =>
      'Експортирайте всяко съобщение, което някога сте изпращали, плюс всичките си настройки на акаунта, членства и метаданни.';

  @override
  String get privacyDashboardDataRequestExportCustom => 'Потребителски избор';

  @override
  String get privacyDashboardDataRequestExportCustomDesc =>
      'Изберете кои видове разговори, общности и времеви прозорец да включите в архива.';

  @override
  String get privacyDashboardDataRequestDeleteSelected =>
      'Изберете какво да включите';

  @override
  String get privacyDashboardDataRequestDeleteSelectedDesc =>
      'Изберете кои типове разговори да изчистите.';

  @override
  String get privacyDashboardDataRequestDeleteInaccessible =>
      'Само места, до които вече нямам достъп';

  @override
  String get privacyDashboardDataRequestDeleteInaccessibleDesc =>
      'Изтриване само на съобщения от общности и групови директни съобщения, които сте напуснали или от които сте били премахнати.';

  @override
  String get privacyDashboardDataRequestKindsTitle => 'Кои разговори';

  @override
  String get privacyDashboardDataRequestKindsBody =>
      'Изберете типовете разговори, които да бъдат включени.';

  @override
  String get privacyDashboardDataRequestKindDms => 'Отворени лични чатове';

  @override
  String get privacyDashboardDataRequestKindDmsClosed =>
      'Затворени лични съобщения';

  @override
  String get privacyDashboardDataRequestKindGroupDms =>
      'Групови директни съобщения';

  @override
  String get privacyDashboardDataRequestKindCommunities => 'Общности';

  @override
  String get privacyDashboardDataRequestCommunitiesTitle => 'Кои общности';

  @override
  String get privacyDashboardDataRequestGuildFilterMode => 'Филтър за общности';

  @override
  String get privacyDashboardDataRequestGuildFilterExclude =>
      'Включи всички освен избраните';

  @override
  String get privacyDashboardDataRequestGuildFilterInclude => 'Само избраните';

  @override
  String get privacyDashboardDataRequestCommunitiesEmpty =>
      'В момента не членувате в общности.';

  @override
  String get privacyDashboardDataRequestWhenTitle => 'Период от време';

  @override
  String get privacyDashboardDataRequestDateMode => 'Период от време';

  @override
  String get privacyDashboardDataRequestAllTime => 'За цялото време';

  @override
  String get privacyDashboardDataRequestCustomRange => 'Персонализиран период';

  @override
  String get privacyDashboardDataRequestStartDate => 'Начална дата';

  @override
  String get privacyDashboardDataRequestEndDate => 'Крайна дата';

  @override
  String get privacyDashboardDataRequestDateHelper =>
      'Оставете което и да е поле празно, за да оставите този край на прозореца неограничен.';

  @override
  String get privacyDashboardDataRequestNeedInclusion =>
      'Изберете поне един вид разговор, който да включите.';

  @override
  String get privacyDashboardDataRequestDateRangeError =>
      'Началната дата трябва да е преди крайната дата.';

  @override
  String get privacyDashboardDataRequestConfirmTitle =>
      'Преглед и потвърждение';

  @override
  String get privacyDashboardDataRequestExportConfirmEverything =>
      'Ще създадем архив за изтегляне на всяко съобщение, което някога сте изпращали, и ще ви изпратим имейл, когато е готов. Връзката за изтегляне в този имейл изтича след 7 дни.';

  @override
  String get privacyDashboardDataRequestExportConfirmCustom =>
      'Ще създадем архив за изтегляне, който отговаря на филтрите по-долу, и ще ви изпратим имейл, когато е готов. Връзката за изтегляне в този имейл изтича след 7 дни.';

  @override
  String get privacyDashboardDataRequestDeleteConfirm =>
      'За постоянно изтриване на съобщенията, които отговарят на филтрите по-долу. Това действие не може да бъде отменено.';

  @override
  String get privacyDashboardDataRequestDeleteDanger =>
      'Няма възстановяване, след като това започне. Ще ви изпратим лично съобщение, когато приключи.';

  @override
  String get privacyDashboardDataRequestRequestExport => 'Заяви експорт';

  @override
  String get privacyDashboardDataRequestDeleteMessages =>
      'Изтриване на съобщения';

  @override
  String get privacyDashboardDataRequestSummaryScope => 'Обхват';

  @override
  String get privacyDashboardDataRequestSummaryConversations => 'Разговори';

  @override
  String get privacyDashboardDataRequestSummaryCommunities => 'Общности';

  @override
  String get privacyDashboardDataRequestSummaryTimeRange => 'Период от време';

  @override
  String get privacyDashboardDataRequestSummaryNone => 'Няма';

  @override
  String privacyDashboardDataRequestSummaryFrom(String start) {
    return 'От $start';
  }

  @override
  String privacyDashboardDataRequestSummaryUntil(String end) {
    return 'До $end';
  }

  @override
  String privacyDashboardDataRequestSummaryBetween(String start, String end) {
    return '$start – $end';
  }

  @override
  String privacyDashboardDataRequestSummaryGuildExclude(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count общности',
      one: '$count общност',
    );
    return 'Всички без $_temp0';
  }

  @override
  String privacyDashboardDataRequestSummaryGuildInclude(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count общности',
      one: '$count общност',
    );
    return 'Само $_temp0';
  }

  @override
  String get privacyDashboardDataRequestSummaryDmsOpen =>
      'Отворени директни съобщения';

  @override
  String get privacyDashboardDataRequestSummaryDmsClosed =>
      'Затворени директни съобщения';

  @override
  String get privacyDashboardDataRequestSummaryDmsBoth =>
      'Директни съобщения (отворени и затворени)';

  @override
  String get privacyDashboardDataRequestSummaryGroupDms =>
      'Групови директни съобщения';

  @override
  String get privacyDashboardDataRequestSummaryCommunitiesIncluded =>
      'Общности';

  @override
  String privacyDashboardDurationHoursMinutes(int hours, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours часа',
      one: '$hours час',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes минути',
      one: '$minutes минута',
    );
    return '$_temp0 и $_temp1';
  }

  @override
  String privacyDashboardDurationHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours часа',
      one: '$hours час',
    );
    return '$_temp0';
  }

  @override
  String privacyDashboardDurationMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes минути',
      one: '$minutes минута',
    );
    return '$_temp0';
  }

  @override
  String privacyDashboardDurationSeconds(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$seconds секунди',
      one: '$seconds секунда',
    );
    return '$_temp0';
  }

  @override
  String get privacyDashboardLoadFailed =>
      'Неуспешно зареждане на настройките за поверителност';

  @override
  String get privacyDashboardRetry => 'Опитай отново';

  @override
  String get privacyDashboardSensitiveContentSaveFailed =>
      'Неуспешно запазване на настройките за чувствително съдържание.';

  @override
  String get privacyDashboardDataRequestFailed =>
      'Неуспешно изпълнение на заявката.';

  @override
  String get chatMessageDeleteFailed => 'Изтрий неуспешно съобщение';

  @override
  String get chatMessageAddReaction => 'Добави реакция';

  @override
  String get doubleTapReactionHint => 'Докоснете двукратно съобщение, за да';

  @override
  String get doubleTapEditHint =>
      'Докосни двукратно свое съобщение, за да го редактираш';

  @override
  String get doubleTapReactionEdit => 'Редактиране';

  @override
  String get doubleTapReactionEditTitle => 'Редактиране на подразбиране';

  @override
  String get doubleTapReactionEditSubtitle =>
      'Изберете емоджи за двойно докосване';

  @override
  String get messagesMediaGesturesSectionTitle => 'Жестове';

  @override
  String get messagesMediaGesturesSectionDescription =>
      'Настрой двукратното докосване и плъзгането върху съобщенията.';

  @override
  String get messagesMediaGesturesReactionLabel => 'Емоджи за реакция';

  @override
  String get messagesMediaGesturesReactionDescription =>
      'Използва се, когато двукратното докосване добавя реакция.';

  @override
  String get messagesMediaGesturesDoubleTapActionLabel =>
      'Действие при двукратно докосване';

  @override
  String get messagesMediaGesturesDoubleTapActionReactName =>
      'Добавяне на реакция';

  @override
  String get messagesMediaGesturesDoubleTapActionReactDescription =>
      'Добавя емоджито ти по подразбиране за двукратно докосване като реакция.';

  @override
  String get messagesMediaGesturesDoubleTapActionEditName =>
      'Редактиране на съобщението';

  @override
  String get messagesMediaGesturesDoubleTapActionEditDescription =>
      'Отваря редактора за съобщенията, които си изпратил. Другите съобщения не се засягат.';

  @override
  String get messagesMediaGesturesDoubleTapActionNoneName => 'Нищо';

  @override
  String get messagesMediaGesturesDoubleTapActionNoneDescription =>
      'Двукратното докосване е изключено.';

  @override
  String get messagesMediaGesturesSwipeRightToLeftLabel =>
      'Плъзгане отдясно наляво';

  @override
  String get messagesMediaGesturesSwipeRightToLeftReplyName =>
      'Плъзгане за отговор';

  @override
  String get messagesMediaGesturesSwipeRightToLeftReplyDescription =>
      'Плъзни съобщение, за да отговориш, и задръж, за да редактираш свои съобщения.';

  @override
  String get messagesMediaGesturesSwipeRightToLeftChannelDetailsName =>
      'Показване на подробностите за канала';

  @override
  String get messagesMediaGesturesSwipeRightToLeftChannelDetailsDescription =>
      'Плъзни съобщение или докосни заглавието на канала, за да отвориш подробностите за канала в страничен панел.';

  @override
  String get chatMessageEdit => 'Редактиране на съобщение';

  @override
  String get chatMessageReply => 'Отговор';

  @override
  String get notificationReplyPlaceholder => 'Съобщение';

  @override
  String get notificationReplyFailed => 'Неуспешно изпращане на отговор';

  @override
  String get chatMessageForward => 'Препращане';

  @override
  String get forwardMessageTitle => 'Препращане на съобщение';

  @override
  String get forwardSearchHint => 'Търсене на канали или директни съобщения';

  @override
  String get forwardDirectMessagesSection => 'Лични съобщения';

  @override
  String get forwardCommentHint => 'Добавяне на коментар (по избор)';

  @override
  String forwardSendButton(int count, int limit) {
    return 'Изпрати ($count/$limit)';
  }

  @override
  String get forwardEmptyState => 'Няма намерени канали';

  @override
  String get forwardSuccessToast => 'Съобщението е препратено';

  @override
  String get forwardCommentSlowmodeDisabled =>
      'Коментарите са недостъпни, защото избраният канал има активиран режим на забавяне.';

  @override
  String get forwardSendSlowmodeBlocked =>
      'Изчаква се да изтече бавният режим в един или повече избрани канала.';

  @override
  String get slowmodeRateLimitedTitle => 'Забавен режим е активен';

  @override
  String slowmodeRateLimitedMessage(String duration) {
    return 'Включен е бавен режим — изчакайте $duration, преди да изпратите друго съобщение.';
  }

  @override
  String get chatAttachmentDropSlowmodeDisabled =>
      'Директното качване е забранено по време на бавен режим.';

  @override
  String get shareMediaTitle => 'Сподели в';

  @override
  String get shareMediaMessageHint => 'Добавете съобщение по избор…';

  @override
  String get shareMediaSendButton => 'Изпращане';

  @override
  String get shareMediaSuccessToast => 'Медията е споделена';

  @override
  String shareMediaPartialSuccessToast(int count) {
    return 'Споделено с $count дестинации';
  }

  @override
  String get shareMediaFailedToast => 'Неуспешно споделяне на медия';

  @override
  String get forwardDestinationNoSendPermission =>
      'Не можете да изпращате съобщения тук';

  @override
  String get forwardDestinationNoEmbedPermission =>
      'Не можете да вграждате връзки тук';

  @override
  String get forwardDestinationNoAttachPermission =>
      'Не можете да прикачвате файлове тук';

  @override
  String get forwardDestinationGuildSendDisabled =>
      'Изпращането на съобщения е деактивирано в тази общност';

  @override
  String get forwardDestinationTimedOut =>
      'Времето ви за изчакване в тази общност изтече';

  @override
  String forwardDestinationSlowmodeCoolingDown(String remaining) {
    return 'Бавно режим - изчакайте $remaining';
  }

  @override
  String get chatMessageCopyText => 'Копирай съобщение';

  @override
  String get chatMessageCopyEmbedText =>
      'Копирай текста на вграденото съобщение';

  @override
  String get chatMessageTranslate => 'Превеждане';

  @override
  String chatMessageTranslatedFrom(String language) {
    return 'Преведено от $language';
  }

  @override
  String get chatMessageSeeOriginal => 'Виж оригинала';

  @override
  String get chatMessageSeeTranslation => 'Виж превода';

  @override
  String get chatMessageTranslating => 'Превеждане…';

  @override
  String get chatMessageTranslateFailed =>
      'Не успях да преведа това съобщение.';

  @override
  String get chatMessageTranslateUnavailable =>
      'Преводът не е наличен на това устройство.';

  @override
  String get chatMessageSpeak => 'Прочитане на съобщението';

  @override
  String get chatMessageStopSpeaking => 'Спиране на говора';

  @override
  String get chatMessagePin => 'Закачи съобщението';

  @override
  String get chatMessageUnpin => 'Откачи съобщението';

  @override
  String get chatMessageUnpinIt => 'Откачи го';

  @override
  String get chatMessageBookmark => 'Запази съобщение';

  @override
  String get chatMessageRemoveBookmark => 'Премахни отметката';

  @override
  String get chatMessageMarkAsUnread => 'Маркирай като непрочетено';

  @override
  String get chatMessageCopyMessageLink => 'Копирай връзка към съобщение';

  @override
  String get chatMessageOpenLink => 'Отваряне на връзка';

  @override
  String get chatMessageCopyLink => 'Копирай връзка';

  @override
  String get chatMessageCopyMessageId => 'Копирай ID на съобщението';

  @override
  String get chatMessageViewReactions => 'Преглед на реакциите';

  @override
  String get chatMessageRemoveAllReactions => 'Премахване на всички реакции';

  @override
  String get chatMessageDebug => 'Относно съобщение';

  @override
  String get chatMessageDebugSheetTitle => 'Отстраняване на грешки';

  @override
  String get chatMessageDebugCopyJson => 'Копирай JSON';

  @override
  String get chatMessageDebugJsonCopiedToast =>
      'JSON на съобщението е копиран в клипборда';

  @override
  String get chatReactionsSheetTitle => 'Реакции';

  @override
  String get chatReactionsSheetEmpty => 'Все още никой не е реагирал с това.';

  @override
  String get chatReactionAddFailed => 'Неуспешно добавяне на реакция';

  @override
  String get chatReactionRemoveFailed => 'Неуспешно премахване на реакция';

  @override
  String get chatMessageReport => 'Докладвай съобщение';

  @override
  String get reportFlowTitleMessage => 'Докладване на съобщение';

  @override
  String get reportFlowTitleUserProfile => 'Докладване на профил';

  @override
  String get reportFlowSummaryTitle => 'Провери сигнала си';

  @override
  String get reportFlowSummarySubtitle =>
      'Увери се, че всичко изглежда правилно, преди да го изпратиш.';

  @override
  String reportFlowDisclaimer(String guidelines) {
    return 'Докладвай само онова, което искрено смяташ, че нарушава правилата. Злоупотребата със сигнали противоречи на $guidelines ни.';
  }

  @override
  String get reportFlowCommunityGuidelinesLink => 'насоките на общността';

  @override
  String get reportFlowDisclaimerNoLink =>
      'Докладвай само онова, което искрено смяташ, че нарушава правилата, и моля те, не изпращай един и същ сигнал два пъти.';

  @override
  String get reportFlowSelectedMessage => 'Съобщение, което докладваш';

  @override
  String get reportFlowSelectedUser => 'Профил, който докладваш';

  @override
  String get reportFlowReportCategory => 'Отговорите ти';

  @override
  String get reportFlowSubmit => 'Изпращане на сигнал';

  @override
  String get reportFlowBack => 'Назад';

  @override
  String get reportFlowNext => 'Напред';

  @override
  String get reportFlowDone => 'Готово';

  @override
  String get reportFlowThankYouTitle => 'Сигналът е изпратен';

  @override
  String get reportFlowThankYouNoReportTitle =>
      'Благодарим, че сигнализира за това';

  @override
  String reportFlowThankYouBody(String productName) {
    return 'Екипът за безопасност на $productName ще прегледа сигнала ти. Няма да разкриваме, че идва от теб.';
  }

  @override
  String get reportFlowThankYouNoReportBody =>
      'Благодарим, че ни каза. Само по себе си това не нарушава правилата ни, затова не изпратихме сигнал. Ако е насочено към някого или съдържа обидни думи, докладвай отново и избери „Обидно или вредно съдържание“.';

  @override
  String get reportFlowThankYouNoReportBodyShort =>
      'Благодарим, че ни каза. Само по себе си това не нарушава правилата ни, затова не изпратихме сигнал.';

  @override
  String get reportFlowMoreYouCanDo => 'Възможностите ти';

  @override
  String reportFlowBlockName(String name) {
    return 'Блокиране на $name';
  }

  @override
  String get reportFlowBlockDescription =>
      'Скрива съобщенията им и им пречи да ти пишат';

  @override
  String get reportFlowBlockButton => 'Блокиране';

  @override
  String get reportFlowBlockedButton => 'Блокирано';

  @override
  String get reportFlowUrgentBanner =>
      'Ако някой е в непосредствена опасност, първо се свържи с местните служби за спешна помощ.';

  @override
  String get reportFlowLoadFailed =>
      'Не успяхме да заредим формуляра за подаване на сигнал.';

  @override
  String get reportFlowTryAgain => 'Опитай отново';

  @override
  String get reportFlowOutdated =>
      'Формулярът за подаване на сигнал се промени. Моля, започни отначало.';

  @override
  String get reportFlowAlreadyReported =>
      'За това съобщение вече има подаден от теб сигнал.';

  @override
  String get reportFlowAlreadyReportedProfile =>
      'За този профил днес вече има подаден от теб сигнал.';

  @override
  String get reportFlowRateLimited =>
      'Изпращаш сигнали твърде бързо. Опитай отново по-късно.';

  @override
  String get reportFlowSubmitFailed =>
      'Сигналът ти не беше изпратен. Опитай отново.';

  @override
  String get reportFlowAccountSetupRequired =>
      'Заяви акаунта си и потвърди имейла си, за да изпращаш сигнали.';

  @override
  String get chatMessageSuppressEmbeds => 'Скриване на вграждания';

  @override
  String get chatMessageUnsuppressEmbeds => 'Покажи отново връзките';

  @override
  String get chatMessageDelete => 'Изтрий съобщението';

  @override
  String get chatMessageDeleteConfirmTitle => 'Изтрий съобщение';

  @override
  String get chatMessageDeleteConfirmDescription =>
      'Сигурни ли сте, че искате да изтриете това съобщение?';

  @override
  String get chatMessageDeleteAttachment => 'Изтрий прикачения файл';

  @override
  String get chatMessageDeleteAttachmentConfirmDescription =>
      'Сигурни ли сте, че искате да изтриете този прикачен файл?';

  @override
  String get chatMessageEditAttachmentAltText =>
      'Редактиране на алтернативен текст';

  @override
  String get chatMessageMore => 'Още';

  @override
  String get chatEditingMessage => 'Редактиране на съобщение';

  @override
  String get chatReplyOriginalDeleted => 'Оригиналното съобщение е изтрито';

  @override
  String get chatReplyOriginalFailedToLoad =>
      'Неуспешно зареждане на оригиналното съобщение';

  @override
  String get chatReplyAttachedMedia => 'Съобщението съдържа прикачени медии';

  @override
  String chatBlockedMessagesCollapsed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count блокирани съобщения',
      one: '1 блокирано съобщение',
    );
    return '$_temp0';
  }

  @override
  String chatSpammerMessagesCollapsed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count потенциални спам съобщения',
      one: '1 потенциално спам съобщение',
    );
    return '$_temp0';
  }

  @override
  String get chatReplyHiddenBlockedAuthor =>
      'Отговорът е скрит, защото оригиналният автор е блокиран.';

  @override
  String get chatReplyHiddenSpammerAuthor =>
      'Отговорът е скрит, защото оригиналният автор е маркиран като спамер.';

  @override
  String get devMarkAsSpamLocally => 'Маркирай като спам (локално)';

  @override
  String get devIgnoreSpamFlag => 'Игнориране на сигнал за спам';

  @override
  String get chatMessagesLoadError => 'Не успяхме да заредим съобщенията.';

  @override
  String get chatMessagesFailedToLoad => 'Съобщенията не можаха да се заредят';

  @override
  String get chatReplyMentionOverrideTitle =>
      'Да промените предпочитанията за споменаване?';

  @override
  String chatReplyMentionPrefersMentionBody(String authorNickname) {
    return '$authorNickname предпочита да бъде споменат с @ в отговорите. Да изпратя ли без споменаване?';
  }

  @override
  String chatReplyMentionPrefersNoMentionBody(String authorNickname) {
    return '$authorNickname предпочита отговори без @споменаване. Да изпратя ли със споменаване все пак?';
  }

  @override
  String get chatReplyMentionIgnorePreference =>
      'Игнориране на предпочитанието';

  @override
  String get chatReplyMentionDisableTooltip =>
      'Кликнете, за да изключите известяването на потребителя, на когото отговаряте.';

  @override
  String get chatReplyMentionEnableTooltip =>
      'Натиснете, за да разрешите изпращането на известие до потребителя, на когото отговаряте.';

  @override
  String get chatReplyMentionAccessibilityLabel =>
      'Споменаване на потребителя, на когото е отговорено';

  @override
  String get chatReplyMentionOn => 'ВКЛ.';

  @override
  String get chatReplyMentionOff => 'ИЗКЛ.';

  @override
  String get chatReplyCancel => 'Отказ на отговора';

  @override
  String get chatEditMessageHint => 'Редактиране на съобщението';

  @override
  String get chatEditNoChanges => 'Няма промени за запазване';

  @override
  String get chatEditFailed => 'Съобщението ти не беше актуализирано';

  @override
  String get chatEditFailedEditAgain => 'Редактирай отново';

  @override
  String get chatChannelNotReady =>
      'Този канал все още не е готов. Опитайте отново след малко.';

  @override
  String get chatMessageEdited => '(редактирано)';

  @override
  String get chatMessageSilent => 'Това беше @silent съобщение.';

  @override
  String chatMessageTimestampToday(String time) {
    return 'Днес в $time';
  }

  @override
  String chatMessageTimestampYesterday(String time) {
    return 'Вчера в $time';
  }

  @override
  String get mediaViewerImagePreview => 'Преглед на изображението';

  @override
  String get mediaViewerClose => 'Затваряне на прегледа на медия';

  @override
  String get mediaViewerOpenInBrowser => 'Отваряне в браузър';

  @override
  String get mediaViewerOptions => 'Опции за медия';

  @override
  String get mediaViewerCopyLink => 'Копирай връзка';

  @override
  String get mediaViewerForward => 'Препращане';

  @override
  String get mediaViewerZoomIn => 'Увеличаване';

  @override
  String get mediaViewerZoomOut => 'Намаляване';

  @override
  String get mediaViewerPreviousAttachment => 'Предишен прикачен файл';

  @override
  String get mediaViewerNextAttachment => 'Следващ прикачен файл';

  @override
  String mediaViewerAttachmentIndex(int current, int total) {
    return '$current/$total';
  }

  @override
  String mediaViewerAttachmentThumbnail(int index) {
    return 'Прикачен файл $index';
  }

  @override
  String get mediaViewerDismissBackdrop => 'Затвори';

  @override
  String get chatAttachmentVideoToggleControls =>
      'Показване/скриване на контролите за видео';

  @override
  String get chatAttachmentVideoMute => 'Заглуши видеото';

  @override
  String get chatAttachmentVideoUnmute => 'Включване на звука на видеото';

  @override
  String get chatAttachmentVideoPlay => 'Пусни видеото';

  @override
  String get chatAttachmentVideoPause => 'Пауза на видеото';

  @override
  String get chatAttachmentVideoProgress => 'Напредък на видеото';

  @override
  String get chatVideoPlaybackFailed =>
      'Не може да се възпроизведе това видео.';

  @override
  String get chatImageCouldNotLoad => 'Изображението не можа да бъде заредено.';

  @override
  String get composerAutocompleteRoleMentionDescription =>
      'Извести потребителите с тази роля, които имат разрешение да виждат този канал.';

  @override
  String get composerAutocompleteSuggestions => 'Предложения';

  @override
  String get composerAutocompleteCommandsHeading => 'Команди';

  @override
  String get composerAutocompleteChoicesHeading => 'Избор';

  @override
  String get composerAutocompleteOptionalArgumentsHeading =>
      'Незадължителни аргументи';

  @override
  String get composerAutocompleteMediaHeading => 'Медия';

  @override
  String get composerAutocompleteStickersHeading => 'Стикери';

  @override
  String get composerAutocompleteEmojisHeading => 'Емоджита';

  @override
  String get composerAutocompleteGifsHeading => 'GIF-ове';

  @override
  String get composerAutocompleteNoGifs => 'Не са намерени GIF файлове';

  @override
  String get composerCommandShrugDescription =>
      'Добавя ¯\\_(ツ)_/¯ към съобщението ви.';

  @override
  String get composerCommandTableflipDescription =>
      'Добавя (╯°□°)╯︵ ┻━┻ към съобщението ви.';

  @override
  String get composerCommandUnflipDescription =>
      'Добавя ┬─┬ ノ( ゜-゜ノ) към съобщението ви.';

  @override
  String get composerCommandMeDescription =>
      'Изпращане на съобщение за действие (показва се в курсив).';

  @override
  String get composerCommandSpoilerDescription =>
      'Изпращане на спойлер съобщение (обвива се в спойлер тагове).';

  @override
  String get composerCommandTtsDescription =>
      'Изпращане на съобщение с преобразуване на текст в говор.';

  @override
  String get composerCommandNickDescription =>
      'Промени прякора си в тази общност.';

  @override
  String get composerCommandKickDescription =>
      'Изключване на член от общността.';

  @override
  String get composerCommandBanDescription =>
      'Забраняване на достъп на член до тази общност.';

  @override
  String get composerCommandMsgDescription =>
      'Изпращане на лично съобщение до потребител.';

  @override
  String get composerCommandSavedDescription => 'Изпращане на запазена медия.';

  @override
  String get composerCommandStickerDescription => 'Изпрати стикер.';

  @override
  String get composerCommandGifDescription => 'Търсене и изпращане на GIF.';

  @override
  String get composerCommandMemberOption =>
      'Членът, към когото да бъде насочено действие.';

  @override
  String get composerCommandReasonOption => 'Причина (по избор).';

  @override
  String get composerCommandMessageOption => 'Съобщението за изпращане.';

  @override
  String get composerCommandQueryOption => 'Какво да търсите.';

  @override
  String get composerCommandNicknameOption =>
      'Вашият нов прякор или оставете празно, за да го нулирате.';

  @override
  String get composerCommandDeleteMessagesOption =>
      'Колко от скорошните съобщения на члена да бъдат изтрити.';

  @override
  String get composerCommandDeleteMessagesNone => 'Не изтривай нито едно';

  @override
  String composerCommandDeleteMessagesDays(int count) {
    return 'Предишни $count дни';
  }

  @override
  String get composerCommandDeleteMessagesOneDay => 'Предишни 24 часа';

  @override
  String get composerCommandOptionRequired =>
      'Тази опция е задължителна. Моля, въведете стойност.';

  @override
  String get composerCommandClear => 'Изчисти команда';

  @override
  String composerCommandNicknameChanged(
    String previousNickname,
    String newNickname,
  ) {
    return 'Променихте прякора си в тази общност от **$previousNickname** на **$newNickname**.';
  }

  @override
  String get composerCommandUnknownUser => 'Неизвестен потребител';

  @override
  String composerCommandMsgFailed(String username) {
    return 'Не успях да изпратя съобщение до **$username**. Възможно е той/тя да е деактивирал/а личните съобщения или да сте блокиран/а.';
  }

  @override
  String composerCommandOptionalMore(int count) {
    return '+$count още';
  }

  @override
  String get addGuildModalTitle => 'Добавяне на общност';

  @override
  String get addGuildModalLandingDescription =>
      'Създайте нова общност или се присъединете към съществуваща.';

  @override
  String get addGuildCreateCommunity => 'Създаване на общност';

  @override
  String get addGuildJoinCommunity => 'Присъединяване към общността';

  @override
  String get addGuildImportDiscordTemplate =>
      'Импортиране на шаблон от Discord';

  @override
  String get addGuildJoinTitle => 'Присъединяване към общност';

  @override
  String get addGuildJoinDescription =>
      'Въведете линка за покана, за да се присъедините към общност.';

  @override
  String get addGuildInviteLinkLabel => 'Линк за покана';

  @override
  String get addGuildJoinSubmit => 'Присъединяване към общността';

  @override
  String get addGuildInviteInvalid => 'Тази покана е невалидна или е изтекла.';

  @override
  String get addGuildCreateTitle => 'Създаване на общност';

  @override
  String get addGuildCreateDescription =>
      'Създайте общност, в която вие и приятелите ви да си чатите.';

  @override
  String get addGuildCreateNameLabel => 'Име на общността';

  @override
  String get addGuildCreateSubmit => 'Създаване на общност';

  @override
  String get addGuildCreateFailed =>
      'Не успяхме да създадем общността. Моля, опитайте отново.';

  @override
  String get addGuildCreateClaimTitle => 'Заяви акаунта си';

  @override
  String get addGuildCreateClaimDescription =>
      'Трябва да потвърдите профила си, преди да можете да създадете общност.';

  @override
  String get addGuildCreateVerifyTitle => 'Потвърдете имейла си';

  @override
  String get addGuildCreateVerifyDescription =>
      'Трябва да потвърдите имейл адреса си, преди да можете да създадете общност.';

  @override
  String get addGuildCreateAnimatedIconUnsupported =>
      'Анимираните икони не се поддържат при създаване на нова общност. Използвайте статично изображение.';

  @override
  String get addGuildCreateGuidelinesBefore =>
      'Създавайки общност, вие се съгласявате да следвате и спазвате ';

  @override
  String addGuildCreateGuidelinesLink(String productName) {
    return 'Правила на общността на $productName';
  }

  @override
  String get addGuildCreateSingleCommunityBlocked =>
      'Тази инстанция е единична общност, така че не могат да бъдат създадени допълнителни общности.';

  @override
  String get addGuildCreateChangeIcon => 'Смяна на икона';

  @override
  String get addGuildCreateIconLabel => 'Икона на общността';

  @override
  String get addGuildCreateIconHint =>
      'PNG, JPEG, WebP, AVIF, HEIC, HEIF, JXL, SVG. Макс. 10MB. Препоръчително: 512×512px';

  @override
  String get addGuildImportDescription =>
      'Поставете URL адрес на шаблон от Discord, за да импортирате неговата структура в нова общност.';

  @override
  String get addGuildImportUrlLabel => 'URL на шаблон';

  @override
  String get addGuildImportUrlInvalid =>
      'Въведете валиден URL адрес или код на шаблон на Discord.';

  @override
  String get addGuildImportFetchFailed =>
      'Не успяхме да изтеглим шаблона за общността. Шаблонът може да не съществува или външната услуга да е недостъпна.';

  @override
  String get addGuildImportInvalidResponse =>
      'Това не изглежда като валиден отговор на шаблон.';

  @override
  String get addGuildImportTemplateLabel => 'Шаблон';

  @override
  String addGuildImportTemplateStats(
    int textChannelCount,
    int voiceChannelCount,
    int categoryCount,
    int roleCount,
  ) {
    return '$textChannelCount текстови, $voiceChannelCount гласови, $categoryCount категории, $roleCount роли';
  }

  @override
  String get addGuildImportRemoveIcon => 'Премахване на икона';

  @override
  String get addGuildImportTemplateInvalid =>
      'Данните за шаблона на общността са невалидни или повредени.';

  @override
  String get chatMessageRemoveAllReactionsConfirmTitle =>
      'Премахни всички реакции';

  @override
  String get chatMessageRemoveAllReactionsConfirmDescription =>
      'Сигурни ли сте, че искате да премахнете всички реакции от това съобщение?';

  @override
  String get chatMessagePinConfirm => 'Закачи';

  @override
  String get chatMessagePinConfirmDescription =>
      'Закачи това съобщение в канала, за да го виждат всички.';

  @override
  String get chatMessageUnpinConfirmTitle => 'Откачи съобщението';

  @override
  String get chatMessageUnpinConfirmDescription =>
      'Да върна ли този карфица назад във времето?';

  @override
  String systemPinMessage(
    String username,
    String messageLink,
    String allPinsLink,
  ) {
    return '$username закачи $messageLink в този канал. Вижте $allPinsLink.';
  }

  @override
  String get systemPinMessageMessageLink => 'съобщение';

  @override
  String get systemPinMessageAllPinsLink => 'всички прикачени съобщения';

  @override
  String get channelPinsEmptyTitle => 'Няма закачени съобщения';

  @override
  String get channelPinsEmptyDescription =>
      'Закачените съобщения се показват тук.';

  @override
  String get channelDetailsFallbackTitle => 'Подробности';

  @override
  String channelDetailsGroupDmSubtitle(int count) {
    return 'Групов личен чат · $count членове';
  }

  @override
  String channelDetailsCloseDmDescription(String name) {
    return 'Затвори разговора си с $name?';
  }

  @override
  String channelDetailsLeaveGroupDescription(String name) {
    return 'Напуснете $name?';
  }

  @override
  String get channelDetailsChannelSettingsTitle => 'Настройки на канала';

  @override
  String get channelDetailsGroupSettingsTitle => 'Настройки на групата';

  @override
  String get channelDetailsDmSettingsTitle => 'Настройки на ЛС';

  @override
  String get channelDetailsInvitePeople => 'Покани хора';

  @override
  String get channelDetailsCopyLink => 'Копирай връзката';

  @override
  String get channelMenuCopyChannelLink => 'Копиране на връзка към канала';

  @override
  String get channelMenuCopyRedirectLink => 'Копирай връзка за пренасочване';

  @override
  String get channelDetailsAddFriendsToGroup =>
      'Добавяне на приятели в групата';

  @override
  String get channelDetailsGroupInvites => 'Покани за група';

  @override
  String get channelDetailsEditChannel => 'Редактиране на канала';

  @override
  String get channelDetailsDeleteChannel => 'Изтриване на канала';

  @override
  String get channelSettingsEditCategory => 'Редактиране на категория';

  @override
  String get channelSettingsTabOverview => 'Общ преглед';

  @override
  String get channelSettingsTabPermissions => 'Разрешения';

  @override
  String get channelSettingsTabInvites => 'Покани';

  @override
  String get channelSettingsTabWebhooks => 'Уебкуки';

  @override
  String get channelSettingsDeleteChannel => 'Изтриване на канала';

  @override
  String channelSettingsDeleteChannelConfirm(String channelName) {
    return 'Сигурни ли сте, че искате да изтриете $channelName? Това действие не може да бъде отменено.';
  }

  @override
  String channelSettingsDeleteCategoryConfirm(String categoryName) {
    return 'Сигурни ли сте, че искате да изтриете $categoryName? Това действие не може да бъде отменено.';
  }

  @override
  String get channelSettingsDeleteCategory => 'Изтриване на категорията';

  @override
  String get channelSettingsChannelUpdated => 'Каналът е актуализиран';

  @override
  String get channelSettingsChannelName => 'Име на канала';

  @override
  String get channelSettingsCategoryName => 'Име на категорията';

  @override
  String get channelSettingsMyCategory => 'Моята категория';

  @override
  String get categoryExpandCategory => 'Разгъване на категорията';

  @override
  String get categoryCollapseCategory => 'Свиване на категорията';

  @override
  String get categoryExpandAllCategories => 'Разгъване на всички категории';

  @override
  String get categoryCollapseAllCategories => 'Свиване на всички категории';

  @override
  String get categoryMuteCategory => 'Изключване на категорията';

  @override
  String get categoryUnmuteCategory => 'Включване на категорията';

  @override
  String get categoryCopyCategoryId => 'Копиране на ID на категория';

  @override
  String get categoryIdCopied => 'ИД на категорията е копиран';

  @override
  String get channelSettingsChannelNamePlaceholder => 'общи';

  @override
  String get channelSettingsUrl => 'URL адрес';

  @override
  String get channelSettingsUrlPlaceholder => 'https://example.com';

  @override
  String get channelSettingsTopic => 'Тема';

  @override
  String get channelSettingsTopicPlaceholder =>
      'Добавяне на тема към този канал';

  @override
  String get channelSettingsInsertEmoji => 'Вмъкване на емоджи';

  @override
  String get channelSettingsTopicTooLongTitle =>
      'Темата на канала е твърде дълга.';

  @override
  String get channelSettingsTopicTooLongMessage =>
      'Съкратете темата и опитайте отново.';

  @override
  String get channelSettingsSlowmode => 'Бавен режим';

  @override
  String channelSettingsSlowmodeDescription(
    String bypassSlowmodePermissionLabel,
  ) {
    return 'Време между съобщенията. „$bypassSlowmodePermissionLabel“ може да го заобиколи.';
  }

  @override
  String get channelSettingsSlowmodeOff => 'Изкл';

  @override
  String channelSettingsSlowmodeSeconds(int seconds) {
    return '$seconds секунди';
  }

  @override
  String channelSettingsSlowmodeMinutes(int minutes) {
    return '$minutes минути';
  }

  @override
  String channelSettingsSlowmodeHours(int hours) {
    return '$hours часа';
  }

  @override
  String channelSettingsSlowmodeOneMinute(int oneMinute) {
    return '$oneMinute минута';
  }

  @override
  String channelSettingsSlowmodeOneHour(int oneHour) {
    return '$oneHour час';
  }

  @override
  String get channelSettingsVoiceQuality => 'Качество на гласа';

  @override
  String get channelSettingsVoiceQualityDescription =>
      'По-висока скорост на трансфер = по-добро качество и по-висока употреба на трафик.';

  @override
  String channelSettingsVoiceQualityKbps(int kilobits) {
    return '$kilobits кбит/с';
  }

  @override
  String get channelSettingsParticipantLimit => 'Лимит на участниците';

  @override
  String get channelSettingsParticipantLimitDescription =>
      'Максимален брой членове, които могат да се присъединят едновременно. 0 означава неограничен.';

  @override
  String channelSettingsParticipantLimitValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count участници',
      one: '1 участник',
      zero: '∞ Без ограничение',
    );
    return '$_temp0';
  }

  @override
  String get channelSettingsConnectionLimit => 'Ограничение на връзките';

  @override
  String get channelSettingsConnectionLimitDescription =>
      'Максимален брой активни връзки, които един член може да поддържа в този канал.';

  @override
  String channelSettingsConnectionLimitValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count връзки',
      one: '1 връзка',
    );
    return '$_temp0';
  }

  @override
  String get channelSettingsVoiceRegion => 'Гласов регион';

  @override
  String get channelSettingsVoiceRegionDescription =>
      'Изберете гласов регион за този канал. Автоматично използва най-близкия регион.';

  @override
  String get channelSettingsVoiceRegionAutomatic => 'Автоматично';

  @override
  String get channelSettingsVoiceRegionsLoadFailed =>
      'Неуспешно зареждане на гласовите региони';

  @override
  String get channelSettingsVoiceRegionsLoadFailedDescription =>
      'Опитайте отново след малко.';

  @override
  String channelSettingsMatureContentSectionDescription(String scopeLevel) {
    return 'Задай нивото $scopeLevel за този канал. Съдържание за възрастни се показва зад предпазна мярка преди влизане.';
  }

  @override
  String get channelSettingsMatureContentInherit => 'Наследяване';

  @override
  String get channelSettingsMatureContentOn => 'Вкл';

  @override
  String get channelSettingsMatureContentOff => 'Изкл';

  @override
  String get channelSettingsMatureContentOnDescription =>
      'Маркира този канал като съдържащ неподходящо съдържание.';

  @override
  String get channelSettingsMatureContentOffDescription =>
      'Остави този канал без ограничения за съдържание за възрастни.';

  @override
  String channelSettingsMatureContentInheritsOn(String inheritedSourceLabel) {
    return 'Наследено от $inheritedSourceLabel: включено';
  }

  @override
  String channelSettingsMatureContentInheritsOff(String inheritedSourceLabel) {
    return 'Наследено от $inheritedSourceLabel: изключено';
  }

  @override
  String get channelSettingsMatureContentCategoryScope => 'Категория';

  @override
  String get channelSettingsMatureContentCommunityScope => 'Общност';

  @override
  String get channelSettingsContentWarningToggle =>
      'Показване на предупреждение за съдържание в този канал';

  @override
  String get channelSettingsContentWarningToggleDescription =>
      'Включва подкана за съгласие преди влизане в този канал.';

  @override
  String get channelSettingsContentWarningText =>
      'Персонализиран текст за предупреждение';

  @override
  String get channelSettingsContentWarningDefault =>
      'Това съдържа чувствително съдържание.';

  @override
  String get channelSettingsUnknownRole => 'Неизвестна роля';

  @override
  String get channelSettingsUnknownUser => 'Неизвестен потребител';

  @override
  String get channelSettingsEveryoneRole => '@everyone';

  @override
  String get channelSettingsPermissionsAccessOverrides =>
      'Персонализиран достъп';

  @override
  String channelSettingsPermissionsEditAccessFor(String name) {
    return 'Редактиране на достъпа за $name';
  }

  @override
  String get channelSettingsPermissionsBackToOverrides =>
      'Назад към презаписванията';

  @override
  String get channelSettingsPermissionsConfigureBaseAccess =>
      'Задаване на основните права за достъп за този канал';

  @override
  String get channelSettingsPermissionsConfigureRoleOverrides =>
      'Конфигуриране на отменяния за тази роля';

  @override
  String get channelSettingsPermissionsConfigureMemberOverrides =>
      'Конфигуриране на отменяния за този член';

  @override
  String get channelSettingsPermissionsSearchPlaceholder =>
      'Търсене на разрешения…';

  @override
  String get channelSettingsPermissionsChannelAccessUpdated =>
      'Достъпът до канала е актуализиран';

  @override
  String get channelSettingsPermissionsTitle => 'Контрол на достъпа';

  @override
  String get channelSettingsPermissionsSyncedWithParentPrefix =>
      'Този канал е синхронизиран с родителската категория ';

  @override
  String get channelSettingsPermissionsSyncedWithParentSuffix => '.';

  @override
  String get channelSettingsPermissionsNotSyncedWithParentPrefix =>
      'Този канал не е синхронизиран с родителската категория ';

  @override
  String get channelSettingsPermissionsNotSyncedWithParentSuffix => '.';

  @override
  String get channelSettingsPermissionsSyncWithCategory =>
      'Синхронизиране с категорията';

  @override
  String get channelSettingsPermissionsSyncedWithParentToast =>
      'Каналът е синхронизиран с родителска категория';

  @override
  String get channelSettingsPermissionsAddOverride => 'Добавяне на изключение';

  @override
  String get channelSettingsPermissionsSearchRolesOrMembers =>
      'Търсене на роли или членове…';

  @override
  String get channelSettingsDeleteInvite => 'Изтриване на покана';

  @override
  String get channelSettingsDeleteInviteConfirm =>
      'Да изтрия ли тази покана? Действието не може да бъде отменено.';

  @override
  String get channelSettingsCopyInviteCode => 'Копирай код за покана';

  @override
  String get channelSettingsCopyInviteUrl => 'Копиране на URL за покана';

  @override
  String get channelSettingsWebhookCreated => 'Уебхукът е създаден';

  @override
  String get channelSettingsWebhookCreateFailed =>
      'Неуспешно създаване на уебхук';

  @override
  String get channelSettingsCreateWebhook => 'Създаване на уебхук';

  @override
  String get channelSettingsInvitesDescription =>
      'Управлявайте връзките за покани за този канал.';

  @override
  String get channelSettingsInvitesCreate => 'Създаване на покана';

  @override
  String get channelSettingsInvitesEmpty => 'Няма връзки за покани';

  @override
  String get channelSettingsInvitesEmptyDescription =>
      'Този канал все още няма връзки за покани. Създайте такава, за да поканите хора в канала.';

  @override
  String get channelSettingsInvitesLoadFailedDescription =>
      'Възникна грешка при зареждането на връзките за покани за този канал. Опитайте отново.';

  @override
  String get channelSettingsWebhooksDescription =>
      'Управлявайте входящи уебкуки, които могат да публикуват съобщения в този канал.';

  @override
  String get channelSettingsWebhooksEmpty => 'Няма уебкуки';

  @override
  String get channelSettingsWebhooksEmptyDescription =>
      'Няма конфигурирани уебкуки за този канал. Създайте уебкука, за да позволите на външни приложения да публикуват съобщения.';

  @override
  String get channelSettingsWebhooksUnsupported =>
      'Този канал не поддържа уебкуки.';

  @override
  String channelSettingsWebhooksPermissionRequired(String permission) {
    return 'За да преглеждате и редактирате уебкуки за този канал, се нуждаете от разрешението „$permission“.';
  }

  @override
  String get channelSettingsWebhooksLoadFailedTitle =>
      'Неуспешно зареждане на уебкуки';

  @override
  String get channelSettingsWebhooksLoadFailedDescription =>
      'Възникна грешка при зареждането на уебкуките за този канал. Опитайте отново.';

  @override
  String channelSettingsWebhooksCreatedBy(String creator, String date) {
    return 'Създадено от $creator на $date';
  }

  @override
  String get channelSettingsWebhooksAvatar => 'Аватар';

  @override
  String get channelSettingsWebhooksUploadImage => 'Качване на изображение';

  @override
  String get channelSettingsWebhooksRemove => 'Премахване';

  @override
  String get channelSettingsWebhooksName => 'Име';

  @override
  String get channelSettingsWebhooksNamePlaceholder => 'Име на уебкуката';

  @override
  String get channelSettingsWebhooksChannel => 'Канал';

  @override
  String get channelSettingsWebhooksUrl => 'URL адрес на уеб кука';

  @override
  String get channelSettingsWebhooksCopyUrl =>
      'Копиране на URL адреса на уебкуката';

  @override
  String get channelSettingsWebhooksDelete => 'Изтриване на уебхук';

  @override
  String get channelSettingsWebhooksDeleteFailed =>
      'Неуспешно изтриване на уебкуката';

  @override
  String get channelSettingsWebhooksDeleteConfirm =>
      'Искаш ли да изтриеш този уебхук? Не може да бъде отменено.';

  @override
  String get channelSettingsWebhookTryAgainInAMoment =>
      'Опитайте отново след малко.';

  @override
  String get channelMenuOpenChat => 'Отваряне на чата';

  @override
  String get channelMenuDuplicateChannel => 'Дублиране на канала';

  @override
  String channelDuplicateHelper(String channelName) {
    return 'Новият канал ще използва разрешенията от $channelName.';
  }

  @override
  String channelDuplicateVoiceHelper(String channelName) {
    return 'Новият гласов канал ще използва разрешенията, ограничението за потребители и битрейта от $channelName.';
  }

  @override
  String get channelMenuMoveToCategory => 'Преместване в категория';

  @override
  String get channelMenuNoCategory => 'Без категория';

  @override
  String get channelMoveCategoryFullTitle => 'Категорията е пълна';

  @override
  String channelMoveCategoryFullMessage(int maxChannelsPerCategory) {
    return 'Тази категория вече съдържа максималния брой от $maxChannelsPerCategory канала.';
  }

  @override
  String get channelMenuResetMatureContentAgreeState =>
      'Нулиране на състоянието на съгласието за съдържание за възрастни';

  @override
  String get channelMenuDeleteMyMessagesTitle =>
      'Да изтриете съобщенията си в този канал?';

  @override
  String get channelMenuDeleteMyMessagesDescription =>
      'Това ще изтрие за постоянно всяко съобщение, което някога сте изпратили в този канал. Това действие не може да бъде отменено.';

  @override
  String get channelMenuDeleteMyMessagesConfirm => 'Изтрий моите съобщения';

  @override
  String get channelMenuDeletedYourMessages => 'Изтрихте вашите съобщения';

  @override
  String get channelMenuCouldNotDeleteYourMessages =>
      'Съобщенията ви не можаха да бъдат изтрити';

  @override
  String get channelDetailsSystemMessage => 'Системно съобщение';

  @override
  String get channelDetailsTextChannel => 'Текстов канал';

  @override
  String get channelDetailsVoiceChannel => 'Гласов канал';

  @override
  String get channelDetailsCategory => 'Категория';

  @override
  String get channelDetailsLinkChannel => 'Свързване на канал';

  @override
  String get channelDetailsGenericChannel => 'Канал';

  @override
  String get channelDetailsMutedConversation => 'Заглушен разговор';

  @override
  String get channelDetailsUnmutedConversation =>
      'Разговорите вече не са заглушени';

  @override
  String get channelDetailsMutedChannel => 'Заглушен канал';

  @override
  String get channelDetailsUnmutedChannel => 'Каналът е отменен';

  @override
  String get channelDetailsNotificationSettingsUpdated =>
      'Настройките за известия са актуализирани';

  @override
  String get channelDetailsTabMembers => 'Членове';

  @override
  String get channelDetailsTabPins => 'Закачени';

  @override
  String get channelDetailsActionMute => 'Заглуши';

  @override
  String get channelDetailsActionUnmute => 'Включване на звука';

  @override
  String get channelDetailsActionSearch => 'Търсене';

  @override
  String get channelDetailsActionMore => 'Още';

  @override
  String get channelDetailsMembersEmptyTitle => 'Няма членове за показване';

  @override
  String get channelDetailsMembersEmptyBody =>
      'Членовете ще се появят тук, след като данните за общността бъдат заредени.';

  @override
  String get memberListPermissionDeniedTitle => 'Не можеш да виждаш членове';

  @override
  String get memberListPermissionDeniedBody =>
      'Не можете да видите членовете на този канал в тази общност';

  @override
  String get memberListUnavailableTitle => 'Списъкът с членове не е наличен';

  @override
  String get memberListUnavailableBody =>
      'Списъците с членове временно не са налични в тази общност';

  @override
  String get channelDetailsPinsLoadFailedTitle =>
      'Не успяхме да заредим пиновете';

  @override
  String get channelDetailsPinsGuildEndHint =>
      'Членовете с разрешение „Закачане на съобщения“ могат да закачат съобщения, които всеки да вижда.';

  @override
  String get channelDetailsPinsDmEndHint =>
      'Можете да закачите съобщения в този разговор, за да ги виждат всички.';

  @override
  String get channelDetailsPinsEndReached => 'Достигнахте края';

  @override
  String get channelHeaderPinnedMessages => 'Закачени съобщения';

  @override
  String get channelHeaderPinnedMessagesUnread =>
      'Закачени съобщения, непрочетени';

  @override
  String get channelHeaderMemberList => 'Списък с членове';

  @override
  String get channelHeaderInbox => 'Входящи';

  @override
  String get channelHeaderNotificationSettingsMuted =>
      'Настройки на известията, заглушено';

  @override
  String get channelDetailsSearchTitle => 'Търсене';

  @override
  String get channelDetailsSearchHint => 'Търсене на съобщения';

  @override
  String get channelDetailsSearchFilterFrom => 'От';

  @override
  String get channelDetailsSearchFilterHas => 'Има';

  @override
  String get channelDetailsSearchFilterIn => 'В';

  @override
  String get channelDetailsSearchFilterMentions => 'Споменавания';

  @override
  String get channelDetailsSearchFilterMore => 'Още';

  @override
  String get channelDetailsSearchMoreFiltersActive => 'Активен';

  @override
  String channelDetailsSearchChannelsCount(int count) {
    return '$count канала';
  }

  @override
  String channelDetailsSearchUsersCount(int count) {
    return '$count потребители';
  }

  @override
  String get channelDetailsSearchAuthorTypeUser => 'Потребител';

  @override
  String get channelDetailsSearchAuthorTypeBot => 'Бот';

  @override
  String get channelDetailsSearchAuthorTypeWebhook => 'Уебхук';

  @override
  String get channelDetailsSearchFilterByChannel => 'Филтриране по канал';

  @override
  String get channelDetailsSearchChannelsHint => 'Търсене на канали';

  @override
  String get channelDetailsSearchChannelsEmpty => 'Няма намерени канали';

  @override
  String get channelDetailsSearchMoreFiltersPinned => 'Закачени';

  @override
  String get channelDetailsSearchPinnedTrue => 'Само пинове';

  @override
  String get channelDetailsSearchPinnedFalse => 'Изключи закачени';

  @override
  String get channelDetailsSearchClearFilter => 'Изчистване';

  @override
  String get channelDetailsSearchMoreFiltersAuthorType => 'Тип автор';

  @override
  String get channelDetailsSearchMoreFiltersDate => 'Дата';

  @override
  String get channelDetailsSearchMoreFiltersDateMode => 'Режим на дата';

  @override
  String get channelDetailsSearchMoreFiltersPickDate => 'Избери дата';

  @override
  String get channelDetailsSearchMoreFiltersLink => 'Връзка към хост';

  @override
  String get channelDetailsSearchMoreFiltersFileName =>
      'Името на файла съдържа';

  @override
  String get channelDetailsSearchMoreFiltersFileType => 'Разширение на файла';

  @override
  String get channelDetailsSearchContentPoll => 'Анкета';

  @override
  String get channelDetailsSearchContentPollDescription => 'Съобщения с анкета';

  @override
  String get channelDetailsSearchContentForward => 'Препращане';

  @override
  String get channelDetailsSearchContentForwardDescription =>
      'Препратени съобщения';

  @override
  String get channelDetailsSearchFilterSort => 'Сортиране';

  @override
  String get channelHeaderSearchFiltersTitle => 'Филтри за търсене';

  @override
  String get channelHeaderSearchRecentTitle => 'Последни търсения';

  @override
  String get channelHeaderSearchUsersTitle => 'Потребители';

  @override
  String get channelHeaderSearchChannelsTitle => 'Канали';

  @override
  String get channelHeaderSearchValuesTitle => 'Стойности';

  @override
  String get channelHeaderSearchDatesTitle => 'Дати';

  @override
  String get channelHeaderSearchDefaultBadge => 'По подразбиране';

  @override
  String get channelHeaderSearchClearHistory => 'Изчистване';

  @override
  String get channelSearchRemoveRecent => 'Премахване от скорошните търсения';

  @override
  String get channelSearchFiltersButton => 'Филтри';

  @override
  String get channelSearchFilterMenuTitle => 'Филтриране на резултатите';

  @override
  String get channelSearchFilterFromLabel => 'От конкретен човек';

  @override
  String get channelSearchFilterMentionsLabel => 'Споменава конкретен човек';

  @override
  String get channelSearchFilterHasLabel =>
      'Съдържа връзка, файл или вграждане';

  @override
  String get channelSearchFilterInLabel => 'В конкретен канал';

  @override
  String get channelSearchFilterDuringLabel => 'Изпратено на дата';

  @override
  String get channelSearchFilterBeforeLabel => 'Изпратено преди дата';

  @override
  String get channelSearchFilterAfterLabel => 'Изпратено след дата';

  @override
  String get channelSearchFilterPinnedLabel => 'Закачено или незакачено';

  @override
  String get channelSearchFilterAuthorTypeLabel => 'По тип автор';

  @override
  String get channelSearchDateToday => 'Днес';

  @override
  String get channelSearchDateYesterday => 'Вчера';

  @override
  String get channelSearchTabMessages => 'Съобщения';

  @override
  String get channelSearchTabImages => 'Изображения';

  @override
  String get channelSearchTabPins => 'Закачени';

  @override
  String get channelSearchTabLinks => 'Линкове';

  @override
  String get channelSearchTabFiles => 'Файлове';

  @override
  String channelSearchTabCount(String label, int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$label ($countString)';
  }

  @override
  String get channelHeaderSearchFilterDescFrom => 'потребител';

  @override
  String get channelHeaderSearchFilterDescMentions => 'потребител';

  @override
  String get channelHeaderSearchFilterDescHas =>
      'връзка, вграждане, изображение, видео, звук, файл, стикер, …';

  @override
  String get channelHeaderSearchFilterDescBefore => 'дата или период от време';

  @override
  String get channelHeaderSearchFilterDescOn => 'дата или период от време';

  @override
  String get channelHeaderSearchFilterDescDuring => 'дата или период от време';

  @override
  String get channelHeaderSearchFilterDescAfter => 'дата или период от време';

  @override
  String get channelHeaderSearchFilterDescIn => 'канал';

  @override
  String get channelHeaderSearchFilterDescPinned => 'вярно или невярно';

  @override
  String get channelHeaderSearchFilterDescAuthorType =>
      'потребител, бот или уебхук';

  @override
  String get channelHeaderSearchFilterDescLinkFrom =>
      'хост, например example.com';

  @override
  String get channelHeaderSearchFilterDescFileName =>
      'част от име на файл на прикачен файл';

  @override
  String get channelHeaderSearchFilterDescFileType =>
      'файлово разширение, напр. png';

  @override
  String get channelHeaderSearchFilterDescSort => 'време или уместност';

  @override
  String get channelHeaderSearchFilterDescOrder => 'възх. или низх';

  @override
  String channelDetailsSearchResultCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString резултата',
      one: '1 резултат',
    );
    return '$_temp0';
  }

  @override
  String get channelDetailsSearchFilterByUser => 'Филтриране по потребител';

  @override
  String get channelDetailsSearchFilterByContent => 'Филтриране по съдържание';

  @override
  String get channelDetailsSearchSortBy => 'Сортиране на резултатите по';

  @override
  String get channelDetailsSearchIn => 'Търсене в';

  @override
  String get channelDetailsSearchEmptyTitle => 'Търсене в този разговор';

  @override
  String get channelDetailsSearchEmptyBody =>
      'Въведете текст, автор или филтър за съдържание, за да намерите съобщения.';

  @override
  String get channelDetailsSearchIndexingTitle => 'Съобщенията се индексират';

  @override
  String get channelDetailsSearchIndexingBody =>
      'Опитайте отново скоро, след като търсенето завърши индексирането на този обхват.';

  @override
  String get channelDetailsSearchNoResultsTitle => 'Няма резултати';

  @override
  String get channelDetailsSearchNoResultsBody =>
      'Опитайте различни термини за търсене или филтри.';

  @override
  String get channelDetailsMembersOnline => 'Онлайн';

  @override
  String get channelDetailsMembersOffline => 'Извън линия';

  @override
  String get channelDetailsMemberYou => 'Вие';

  @override
  String get channelDetailsSearchUsersHint => 'Търсене на потребители';

  @override
  String get channelDetailsSearchUsersTypeToSearch =>
      'Въведете, за да търсите членове';

  @override
  String get channelDetailsSearchUsersEmpty => 'Няма намерени потребители';

  @override
  String get channelDetailsSearchUsersNoAvailable => 'Няма налични потребители';

  @override
  String get channelDetailsDone => 'Готово';

  @override
  String get channelDetailsHasFilterPrompt =>
      'Покажи съобщения, които съдържат:';

  @override
  String get channelDetailsRetry => 'Опитай отново';

  @override
  String get channelDetailsPinnedMessageTitle => 'Закачено съобщение';

  @override
  String get channelDetailsSearchResultTitle => 'Резултат от търсене';

  @override
  String get channelDetailsJumpToMessage => 'Премини към съобщение';

  @override
  String get channelDetailsUnpinMessage => 'Открепи съобщение';

  @override
  String get channelDetailsCopyMessageLink => 'Копирай връзка към съобщение';

  @override
  String get channelDetailsCopyMessageId => 'Копирай ID на съобщението';

  @override
  String get channelDetailsMessageUnpinned => 'Съобщението е открепено';

  @override
  String get channelDetailsSearchScopeCurrentCommunity => 'Текущата общност';

  @override
  String get channelDetailsSearchScopeCurrentDm => 'Текущ чат';

  @override
  String get channelDetailsSearchScopeAllCommunities => 'Всички общности';

  @override
  String get channelDetailsSearchScopeAllDmsOnlyGuild => 'Само лични съобщения';

  @override
  String get channelDetailsSearchScopeAllDms => 'Всички лични чатове';

  @override
  String get channelDetailsSearchScopeOpenDmsOnlyGuild =>
      'Само отворени лични съобщения';

  @override
  String get channelDetailsSearchScopeOpenDms => 'Отворени лични чатове';

  @override
  String get channelDetailsSearchScopeAllDmsAndCommunities =>
      'Всички лични съобщения + Общности';

  @override
  String get channelDetailsSearchScopeOpenDmsAndCommunities =>
      'Лични съобщения + Общности';

  @override
  String get channelDetailsSearchScopeCurrentCommunityDescription =>
      'Търсене само в тази общност';

  @override
  String get channelDetailsSearchScopeCurrentDmDescription =>
      'Търсене само в този чат';

  @override
  String get channelDetailsSearchScopeAllCommunitiesDescription =>
      'Във всички общности, в които участваш в момента';

  @override
  String get channelDetailsSearchScopeAllDmsOnlyGuildDescription =>
      'Само във всички лични чатове, в които някога сте участвали';

  @override
  String get channelDetailsSearchScopeAllDmsDescription =>
      'Във всички лични чатове, в които някога сте били';

  @override
  String get channelDetailsSearchScopeOpenDmsOnlyGuildDescription =>
      'Във всички отворени директни съобщения само';

  @override
  String get channelDetailsSearchScopeOpenDmsDescription =>
      'Във всички отворени разговори с хора';

  @override
  String get channelDetailsSearchScopeAllDmsAndCommunitiesDescription =>
      'Във всички лични чатове, в които някога си бил + всички общности, в които си в момента';

  @override
  String get channelDetailsSearchScopeOpenDmsAndCommunitiesDescription =>
      'Във всички отворени лични съобщения + всички общности, в които участваш';

  @override
  String get channelDetailsSearchSortNewest => 'Най-новите първо';

  @override
  String get channelDetailsSearchSortOldest => 'Най-стари първо';

  @override
  String get channelDetailsSearchSortRelevance => 'Най-релевантни';

  @override
  String get channelDetailsSearchSortNewestDescription =>
      'Показвай първо най-новите съобщения';

  @override
  String get channelDetailsSearchSortOldestDescription =>
      'Показване на най-старите съобщения първо';

  @override
  String get channelDetailsSearchSortRelevanceDescription =>
      'Показване на най-подходящите съобщения първо';

  @override
  String get channelDetailsSearchContentImage => 'Качване на изображение';

  @override
  String get channelDetailsSearchContentVideo => 'Качване на видео';

  @override
  String get channelDetailsSearchContentAudio => 'Качване на аудио';

  @override
  String get channelDetailsSearchContentFile => 'Качване на файл';

  @override
  String get channelDetailsSearchContentLink => 'Връзка';

  @override
  String get channelDetailsSearchContentEmbed =>
      'Предварителен преглед на връзка или вграждане';

  @override
  String get channelDetailsSearchContentSticker => 'Стикери';

  @override
  String get channelDetailsSearchContentImageDescription =>
      'Само качени изображения';

  @override
  String get channelDetailsSearchContentVideoDescription =>
      'Само качени видеоклипове';

  @override
  String get channelDetailsSearchContentAudioDescription =>
      'Само качени аудиофайлове';

  @override
  String get channelDetailsSearchContentFileDescription =>
      'Всяко качено прикачено съдържание';

  @override
  String get channelDetailsSearchContentLinkDescription =>
      'Въведен URL адрес в текста на съобщението';

  @override
  String get channelDetailsSearchContentEmbedDescription =>
      'Прегледани визуализации и обогатени вграждания, не качвания';

  @override
  String get channelDetailsSearchContentStickerDescription =>
      'Стикер, прикачен към съобщението';

  @override
  String channelDetailsSearchContentTypesCount(int count) {
    return '$count типа';
  }

  @override
  String get personalNotesTitle => 'Лични бележки';

  @override
  String get personalNotesSubtitle =>
      'Вашето лично пространство за мисли и напомняния';

  @override
  String groupDmWelcome(String displayName) {
    return 'Добре дошли в $displayName. Добавете приятели, за да стартирате групата.';
  }

  @override
  String get groupDmWelcomeEditGroup => 'Редактиране на групата';

  @override
  String get groupDmWelcomeAddFriends => 'Добавяне на приятели в групата';

  @override
  String get dmGroupInvites => 'Покани';

  @override
  String get groupDmEditTitle => 'Редактиране на групата';

  @override
  String get groupDmGroupName => 'Име на групата';

  @override
  String get groupDmMyGroup => 'Моята група';

  @override
  String get groupDmGroupNameMaxLength =>
      'Името на групата не може да надвишава 100 знака';

  @override
  String get groupDmGroupIcon => 'Икона на групата';

  @override
  String get groupDmUploadIcon => 'Качване на икона';

  @override
  String get groupDmChangeIcon => 'Смяна на икона';

  @override
  String get groupDmRemoveIcon => 'Премахване на икона';

  @override
  String get groupDmUpdated => 'Групата е актуализирана';

  @override
  String get groupDmUpdateFailed =>
      'Не успях да обновя групата. Опитай отново.';

  @override
  String get groupDmAnimatedIconNotSupported =>
      'Анимираните икони не се поддържат. Използвайте статично изображение.';

  @override
  String get groupDmAnimatedIconNotSupportedTitle =>
      'Анимираните икони не се поддържат';

  @override
  String get groupDmIconFileTooLargeTitle => 'Файлът с иконата е твърде голям';

  @override
  String groupDmIconFileTooLargeBody(String maxSize) {
    return 'Иконата на файла е твърде голяма. Изберете файл, по-малък от $maxSize.';
  }

  @override
  String get groupDmUnsupportedIconFormat => 'Неподдържан формат на иконата';

  @override
  String get groupDmUnsupportedIconFormatBody => 'Неподдържан тип файл.';

  @override
  String get groupDmInvalidImage => 'Невалидно изображение';

  @override
  String get groupDmInvalidImageBody =>
      'Изображението е невалидно. Опитайте друго.';

  @override
  String get groupDmAddFriends => 'Добавяне';

  @override
  String get groupDmOrSendInvite => 'или изпратете покана на приятел:';

  @override
  String get groupDmGenerateInviteLink => 'Генериране на линк за покана';

  @override
  String get groupDmCreateInvite => 'Създаване';

  @override
  String get groupDmInviteExpires24Hours => 'Поканата ви изтича след 24 часа';

  @override
  String get groupDmAddFriendFailed =>
      'Не може да се добави този приятел към групата. Моля, опитайте отново.';

  @override
  String get groupDmGroupFull =>
      'Тази група е пълна. Премахнете някого, преди да добавите още хора.';

  @override
  String get groupDmRateLimited =>
      'Действате твърде бързо. Изчакайте малко и опитайте отново.';

  @override
  String get groupDmCreateInviteFailedBody =>
      'Не може да се генерира връзка за покана. Моля, опитайте отново.';

  @override
  String get guildNavbarCreateInviteFailed =>
      'Не успяхме да създадем връзка за покана. Моля, опитайте отново.';

  @override
  String get guildNavbarCreateInviteMissingPermissions =>
      'Нямате разрешение да създавате покана в този канал.';

  @override
  String get guildNavbarCreateInviteMaxInvites =>
      'Общността е достигнала лимита за покани.';

  @override
  String get groupDmCopyInviteFailed =>
      'Неуспешно копиране на връзката за покана';

  @override
  String get groupDmInvitesOwnerOnly =>
      'Само собственикът на групата може да управлява покани.';

  @override
  String get groupDmNoInvitesCreated => 'Няма създадени покани';

  @override
  String get groupDmLoadingInvites => 'Зареждане на покани...';

  @override
  String get groupDmInvitesLoadFailed =>
      'Неуспешно зареждане на поканите. Опитайте отново.';

  @override
  String get groupDmInvitesRevokeConfirm =>
      'Отменяне на тази покана? Действието не може да бъде отменено.';

  @override
  String get groupDmInviteRevoked => 'Поканата е оттеглена';

  @override
  String get groupDmRemoveFromGroup => 'Премахване от групата';

  @override
  String groupDmRemoveFromGroupConfirm(String userName) {
    return 'Да се премахне ли $userName от групата?';
  }

  @override
  String get groupDmRemoveFromGroupAction => 'Премахване';

  @override
  String get groupDmRemovedFromGroup => 'Премахнат от групата';

  @override
  String groupDmRemoveFromGroupFailed(String userName) {
    return '$userName все още е в групата. Опитай отново след малко.';
  }

  @override
  String groupDmInviteCreatedByExpires(String name, String time) {
    return 'Създадено от $name. Изтича след $time.';
  }

  @override
  String channelWelcomeHeading(String channelName) {
    return 'Добре дошли в $channelName';
  }

  @override
  String channelWelcomeDescription(String channelName) {
    return 'Това е началото на $channelName.';
  }

  @override
  String get personalNotesComposerHint => 'Изпрати съобщение на себе си';

  @override
  String channelComposerHint(String channelName) {
    return 'Съобщение #$channelName';
  }

  @override
  String dmComposerHint(String recipientName) {
    return 'Съобщение до @$recipientName';
  }

  @override
  String groupDmNamedComposerHint(String groupName) {
    return 'Съобщение $groupName';
  }

  @override
  String get groupDmComposerHint => 'Група съобщения';

  @override
  String get composerHint => 'Изпрати съобщение';

  @override
  String get composerOpenExpressionPicker => 'Отвори избор на емотикони';

  @override
  String get composerShowKeyboard => 'Покажи клавиатурата';

  @override
  String get composerCloseAttachmentPanel =>
      'Затвори селектора за прикачени файлове';

  @override
  String get chatAttachmentPanelPhotos => 'Снимки';

  @override
  String get chatAttachmentPanelFiles => 'Файлове';

  @override
  String get chatAttachmentLibraryPermissionTitle =>
      'Необходим е достъп до фотоалбума';

  @override
  String get chatAttachmentLibraryPermissionBody =>
      'Разрешете достъп до фотоалбума, за да разглеждате и прикачвате скорошни снимки и видеоклипове.';

  @override
  String get chatAttachmentLibraryPermissionSettings =>
      'Отваряне на настройките';

  @override
  String get chatAttachmentLibraryLimitedBody =>
      'Тук се показват само снимките и видеоклиповете, които си избрал да споделиш.';

  @override
  String get chatAttachmentLibraryLimitedManage => 'Управление';

  @override
  String messageAccessibilityLabel(String author, String summary) {
    return '$author, $summary';
  }

  @override
  String get messageAccessibilitySendingSuffix => ', изпращане';

  @override
  String get messageAccessibilityFailedSuffix => ', не успя да се изпрати';

  @override
  String get messageAccessibilityAttachmentSummary => 'прикачен файл';

  @override
  String messageAccessibilityAttachmentsSummary(int count) {
    return '$count прикачени файла';
  }

  @override
  String get messageAccessibilityImageSummary => 'изображение';

  @override
  String get messageAccessibilityVideoSummary => 'видео';

  @override
  String get messageAccessibilityAudioSummary => 'аудио файл';

  @override
  String messageAccessibilityStickerSummary(String name) {
    return 'стикер $name';
  }

  @override
  String messageAccessibilityFileSummary(String filename) {
    return 'файл $filename';
  }

  @override
  String get messageAccessibilitySpoilerAttachmentSummary =>
      'прикачен файл със спойлер';

  @override
  String get messageAccessibilityEmbedSummary => 'вграждане';

  @override
  String get messageAccessibilityEmptySummary => 'съобщение';

  @override
  String get personalNotesPrivateSpace => 'Вашето лично пространство';

  @override
  String get purgePersonalNotes => 'Изчистване на лични бележки';

  @override
  String get purgePersonalNotesConfirmDescription =>
      'Това ще изтрие завинаги всяко съобщение и прикачен файл от личните ви бележки. Това действие не може да бъде отменено.';

  @override
  String get purgePersonalNotesConfirmButton => 'Изчистване';

  @override
  String purgePersonalNotesSuccess(int count) {
    return 'Изтрити $count съобщения от лични бележки';
  }

  @override
  String get purgePersonalNotesAlreadyEmpty => 'Личните бележки вече са празни';

  @override
  String get purgePersonalNotesFailed =>
      'Не успяхме да изчистим личните бележки';

  @override
  String get userSettingsGroupYourAccount => 'Вашият профил';

  @override
  String get userSettingsGroupBilling => 'Плащане';

  @override
  String get userSettingsGroupApplication => 'Приложение';

  @override
  String get userSettingsGroupDeveloper => 'Разработчик';

  @override
  String get userSettingsGroupStaffOnly => 'Само за екипа';

  @override
  String get userSettingsSearchPlaceholder => 'Търсене на настройки...';

  @override
  String get userSettingsSearchClear => 'Изчистване на търсенето';

  @override
  String get userSettingsSearchNoResults => 'Няма намерени настройки';

  @override
  String get userSettingsCopyLinkToSection => 'Копирай линка към секцията';

  @override
  String get userSettingsCopyLinkToPage => 'Копирай линка към страницата';

  @override
  String userSettingsJumpLinkPremiumPage(String productName) {
    return 'Страница $productName';
  }

  @override
  String get userSettingsNavProfile => 'Профил';

  @override
  String get userSettingsNavSecurityLogin => 'Сигурност и влизане';

  @override
  String get userSettingsNavFluxerPlutonium => 'echowire Reverb';

  @override
  String get userSettingsNavGiftsAndCodes => 'Подаръци';

  @override
  String get giftSettingsClaimAccountTitle => 'Заяви акаунта си';

  @override
  String get giftSettingsClaimAccountDescription =>
      'Поискай акаунта си, за да осребриш или управляваш кодове за подаръци Reverb.';

  @override
  String get giftSettingsRedeemTitle => 'Активиране на подарък';

  @override
  String get giftSettingsRedeemDescription =>
      'Въведете код за подарък, за да осребрите Reverb за вашия акаунт.';

  @override
  String get giftSettingsRedeemPlaceholder => 'Въвеждане на код за подарък…';

  @override
  String get giftSettingsRedeemButton => 'Използване';

  @override
  String get giftSettingsRedeemSuccess =>
      'Подаръкът е успешно осребрен. Насладете се на Reverb.';

  @override
  String get giftSettingsPurchasedTitle => 'Закупени подаръци';

  @override
  String get giftSettingsPurchasedDescription =>
      'Управлявайте закупените си кодове за подарък Reverb. Споделете URL адреса на подаръка с някого специален или го осребрете за себе си!';

  @override
  String get giftSettingsEmptyTitle => 'Все още няма подаръци';

  @override
  String get giftSettingsEmptyDescription =>
      'Купете Reverb подарък от раздела Reverb, за да го споделите с приятели.';

  @override
  String get giftSettingsGoToPlutonium => 'Отиди в Reverb';

  @override
  String get giftSettingsLoadFailedTitle =>
      'Неуспешно зареждане на инвентара с подаръци';

  @override
  String get giftSettingsLoadFailedDescription => 'Опитайте по-късно.';

  @override
  String get giftSettingsTryAgain => 'Опитай пак';

  @override
  String get giftSettingsGiftUrl => 'URL на подаръка';

  @override
  String get giftSettingsCopy => 'Копирай';

  @override
  String get giftSettingsCopied => 'Копирано';

  @override
  String giftSettingsPurchasedDate(String date) {
    return 'Закупен $date';
  }

  @override
  String giftSettingsRedeemedDate(String date) {
    return 'Получено на $date';
  }

  @override
  String giftSettingsRedeemedBy(String name) {
    return 'Получено от $name';
  }

  @override
  String get giftSettingsAlreadyRedeemed => 'Този подарък е получен';

  @override
  String get giftSettingsRedeemForYourself => 'Използвай за себе си';

  @override
  String get giftSettingsShareWithFriend => 'Сподели с приятел';

  @override
  String get premiumPlutoniumTagline =>
      'Отключете по-високи лимити и ексклузивни функции, докато подкрепяте независима комуникационна платформа.';

  @override
  String get premiumPurchaseMode => 'Режим на покупка';

  @override
  String get premiumForMe => 'За мен';

  @override
  String get premiumAsAGift => 'Като подарък';

  @override
  String get premiumMonthly => 'Месечно';

  @override
  String get premiumYearly => 'Годишно';

  @override
  String get premiumPerMonth => 'на месец';

  @override
  String get premiumPerYear => 'на година';

  @override
  String get premiumOneTimePurchase => 'еднократна покупка';

  @override
  String get premiumSave17 => 'Спестете 17%';

  @override
  String get premiumUpgradeNow => 'Надстройте сега';

  @override
  String get premiumBuyGift => 'Купи подарък';

  @override
  String get premiumOneYearGift => 'Подарък за 1 година';

  @override
  String get premiumOneMonthGift => 'Подарък за 1 месец';

  @override
  String get premiumScrollPrompt =>
      'Превъртете надолу, за да видите всички предимства на Reverb';

  @override
  String get premiumFreeVsPlutonium => 'Безплатно срещу Reverb';

  @override
  String get premiumFreeColumn => 'Безплатно';

  @override
  String get premiumGiftSectionTitle => 'Подарете Reverb';

  @override
  String get premiumGiftSectionDescription =>
      'Сподели Reverb изживяването с приятелите си, като закупиш подаръчен абонамент.';

  @override
  String get premiumGiftBannerOne =>
      'Имаш нов код за подарък, който те очаква!';

  @override
  String premiumGiftBannerMany(int count) {
    return 'Имате $count нови кода за подаръци, които ви очакват!';
  }

  @override
  String get premiumViewGifts => 'Преглед на подаръците';

  @override
  String get premiumReadyToUpgrade => 'Готови ли сте за надграждане?';

  @override
  String get premiumReadyToBuyGift => 'Готови ли сте да купите подарък?';

  @override
  String get premiumManageSubscription => 'Управление на абонамент';

  @override
  String get premiumRedeemGiftCode => 'Използване на код за подарък';

  @override
  String get premiumGiftBadge => 'Подарък';

  @override
  String get premiumCancelSubscriptionTitle => 'Отказване на абонамент?';

  @override
  String get premiumCancelSubscriptionBody =>
      'Запазвате предимствата си до следващата дата на подновяване, след което имате 3-дневен гратисен период, за да се абонирате отново и да запазите историята на абонамента си.';

  @override
  String get premiumCancelSubscriptionConfirm => 'Отказ от абонамент';

  @override
  String get premiumPurchaseHistoryTitle => 'История на покупките';

  @override
  String get premiumPurchaseHistoryDescription =>
      'Вашите скорошни фактури. За да промените начина на плащане на абонамента си, добавете или изберете такъв в портала за фактуриране и го направете основен.';

  @override
  String get premiumManagePaymentMethods => 'Управление на методите за плащане';

  @override
  String get premiumSelfServeRefundButton =>
      'Възстановяване на последната покупка';

  @override
  String get premiumDisclaimerAgreementPrefix =>
      'С покупката се съгласявате с нашите ';

  @override
  String get premiumDisclaimerAgreementPastPrefix =>
      'С покупката се съгласихте с нашите ';

  @override
  String get premiumDisclaimerAgreementMiddle => ' и ';

  @override
  String premiumActiveUntil(String date) {
    return 'Активно до $date';
  }

  @override
  String get premiumSubscriptionCanceling => 'Анулиране';

  @override
  String premiumCancelsOn(String date) {
    return 'Анулиране на $date. Предимствата остават активни дотогава.';
  }

  @override
  String get premiumReactivateSubscription => 'Активиране отново';

  @override
  String premiumGiftedUntil(String date) {
    return 'Подарено до $date. Не се подновява автоматично.';
  }

  @override
  String get premiumGiftGraceEnded =>
      'Времето на подаръка ви изтече. Абонирайте се, за да запазите Plutonium.';

  @override
  String get premiumGiftTimeAddedAfterSubscription =>
      'Ще бъдете таксувани сега. Остатъчното ви безплатно време ще бъде добавено след платената ви услуга, така че няма да загубите нищо.';

  @override
  String get premiumComparisonFeatureColumn => 'Функция';

  @override
  String get premiumDisclaimerRefund =>
      'Възможност за самообслужване на възстановяване на суми до 3 дни след плащане, веднъж на всеки 30 дни. Възстановяването на сума за абонамент го анулира. Купувачите от ЕС/ЕИП се отказват от 14-дневното право на отказ при плащане, за да получат незабавен достъп до съдържанието. Използвайте бутона за възстановяване на сума в приложението вместо оспорване на трансакция. Оспорването на трансакция може трайно да ограничи достъпа до акаунта ви. Stripe обработва плащанията сигурно. Ние никога не виждаме пълния номер на картата ви.';

  @override
  String get premiumTermsOfService => 'Условия за ползване';

  @override
  String get premiumPrivacyPolicy => 'Политика за поверителност';

  @override
  String get premiumCheckoutStartFailedTitle => 'Не може да се започне плащане';

  @override
  String get premiumCheckoutStartFailedBody =>
      'Нещо се обърка при стартирането на плащането. Моля, опитайте отново след малко.';

  @override
  String get premiumPlanUnavailable =>
      'Този план не е наличен. Свържете се с поддръжката.';

  @override
  String get premiumPlanUnavailableSelfHosted =>
      'Този план не е наличен. Свържи се с администраторите на тази инстанция.';

  @override
  String get premiumCompletePaymentTitle => 'Завършване на плащането';

  @override
  String get premiumCompletePaymentBody =>
      'Сега ще бъдете пренасочени към Stripe, за да завършите плащането. Върнете се във echowire, след като сте готови.';

  @override
  String get premiumChoosePaymentMethodTitle => 'Изберете начин на плащане';

  @override
  String get premiumPixPaymentPromptDescription =>
      'Платете с Pix автоматично, за да разрешите повтарящи се такси директно от вашата бразилска банка. Или изберете използване на карта, за да въведете кредитна карта на следващия екран на Stripe.';

  @override
  String get premiumUsePix => 'Използвай Pix';

  @override
  String get premiumUpiPaymentPromptDescription =>
      'Платете с UPI, за да настроите съвместим с RBI електронен мандат от вашата индийска банка. Или изберете „Използване на карта“, за да въведете кредитна карта на следващия екран на Stripe.';

  @override
  String get premiumUseUpi => 'Използвай UPI';

  @override
  String get premiumUseCard => 'Използване на карта';

  @override
  String get premiumCustomerPortalOpenFailedTitle =>
      'Не може да се отвори порталът за плащане';

  @override
  String get premiumCustomerPortalOpenFailedBody =>
      'Нещо се обърка при отварянето на портала за таксуване. Моля, опитайте отново след малко.';

  @override
  String get premiumAlreadyVisionaryTitle => 'Вече сте Визионер';

  @override
  String get premiumAlreadyVisionaryBody =>
      'Visionary вече включва постоянен достъп, така че не е необходим абонамент с периодично плащане. Все още можете да купувате подаръци за други.';

  @override
  String get premiumExistingSubscriptionTitle => 'Вече имате абонамент';

  @override
  String get premiumExistingSubscriptionBody =>
      'Открихме съществуващ абонамент за Reverb за този акаунт. Управлявайте го в защитения портал за плащания, за да актуализирате данните за плащане или да проверите статуса на подновяване. Ако току-що сте платили, изчакайте минута и отворете отново тази страница.';

  @override
  String get premiumPurchasesDisabledTitle => 'Покупки недостъпни';

  @override
  String premiumPurchasesDisabledBody(String supportEmail) {
    return 'Покупки са деактивирани за този акаунт. Свържете се с $supportEmail, ако смятате, че това е грешка.';
  }

  @override
  String get premiumPurchasesDisabledBodySelfHosted =>
      'Покупки са деактивирани за този акаунт. Свържете се с администраторите на тази инстанция, ако смятате, че това е грешка.';

  @override
  String get premiumClaimAccountToPurchase =>
      'Поискай акаунта си, за да закупиш Reverb.';

  @override
  String get premiumVerifyEmailToPurchase =>
      'Трябва да потвърдите имейла си, преди да можете да закупите Reverb.';

  @override
  String get premiumPerkCommunities => 'Общности';

  @override
  String get premiumPerkMessageCharacterLimit =>
      'Лимит на символите в съобщението';

  @override
  String get premiumPerkBookmarkedMessages => 'Запазени съобщения';

  @override
  String get premiumPerkFileUploadSize => 'Размер на качванията на файлове';

  @override
  String get premiumPerkUseAnimatedEmojis => 'Използване на анимирани емоджита';

  @override
  String get premiumPerkVideoQuality => 'Качество на видеото';

  @override
  String get premiumPerkAnimatedAvatarsBanners =>
      'Анимирани аватари и банери на профили';

  @override
  String get premiumPerkEarlyAccess => 'Ранен достъп до нови функции';

  @override
  String get premiumPerkVideoQualityRestricted => '720p/30fps';

  @override
  String get premiumPerkVideoQualityStock => 'До 4K/60 кадъра в секунда';

  @override
  String storePlutoniumPriceLine(String monthly, String yearly) {
    return '$monthly или $yearly';
  }

  @override
  String get storePlutoniumMonthSuffix => '/мес.';

  @override
  String get storePlutoniumYearSuffix => '/год.';

  @override
  String get storePlutoniumPriceOr => 'или';

  @override
  String get storePlutoniumEmojiTitle => 'Вашите емоджита, навсякъде';

  @override
  String get storePlutoniumEmojiBody =>
      'Използвайте персонализирани емоджита и стикери от всяка ваша общност във всеки чат и общност, в която членувате.';

  @override
  String get storePlutoniumProfileTitle => 'Профил, който се откроява';

  @override
  String get storePlutoniumProfileBody =>
      'Вземете анимиран аватар и банер, значка за абонат, желания от вас четирицифрен таг след потребителското си име* и отделен профил за всяка общност.';

  @override
  String get storePlutoniumFilesTitle => 'Изпращайте файлове до 500 MB';

  @override
  String get storePlutoniumFilesBody =>
      'Споделяйте пълнометражни видеоклипове и големи файлове, без да ги свивате предварително. Безплатните акаунти могат да изпращат до 25 MB.';

  @override
  String get storePlutoniumCompareTitle => 'Сравнете безплатния и Plutonium';

  @override
  String get storePlutoniumCompareMobileNote =>
      'Не всички от тези функции са налични в мобилното приложение. Някои са достъпни само на компютър.';

  @override
  String get storePlutoniumNotAvailable => 'Не е налично';

  @override
  String get storePlutoniumAvailable => 'Налична';

  @override
  String get storePlutoniumCompareTag =>
      'Изберете 4-цифреното число след потребителското си име*';

  @override
  String get storePlutoniumCompareProfile => 'Отделен профил за всяка общност';

  @override
  String get storePlutoniumCompareBadge => 'Значка на абонат в профила ви';

  @override
  String get storePlutoniumCompareBackgrounds =>
      'Фонове за видеообаждания, които можете да запазвате';

  @override
  String get storePlutoniumCompareCommunities =>
      'Общности, към които можете да се присъедините';

  @override
  String get storePlutoniumCompareCharacters => 'Символи в едно съобщение';

  @override
  String get storePlutoniumCompareBookmarks =>
      'Съобщения, които можете да запазите';

  @override
  String get storePlutoniumCompareUpload =>
      'Най-големият файл, който можете да качите';

  @override
  String get storePlutoniumCompareSavedMedia =>
      'Медийни елементи, които можете да запазите за по-късно';

  @override
  String get storePlutoniumCompareAnimatedEmoji =>
      'Използвайте анимирани емоджита в съобщенията';

  @override
  String get storePlutoniumCompareCustomEmoji =>
      'Използвайте персонализирани емоджита и стикери във всяка общност';

  @override
  String get storePlutoniumCompareVideo =>
      'Качество на видео разговори и споделяне на екран';

  @override
  String get storePlutoniumCompareAvatar =>
      'Анимиран аватар и банер на профила';

  @override
  String get storePlutoniumCompareEarlyAccess => 'Ранен достъп до нови функции';

  @override
  String get storePlutoniumCompareThemes =>
      'Персонализирани теми за приложението';

  @override
  String get storePlutoniumVideoFree => 'До 720p при 30 FPS';

  @override
  String get storePlutoniumVideoPlutonium => 'До 4K при 60 FPS';

  @override
  String get storePlutoniumTagFootnote =>
      'Можете да изберете само таг, който никой друг със същото потребителско име вече няма. Потребителските имена не правят разлика между малки и главни букви, така че Mina#4821 и mina#4821 се броят за едно и също. Тагът #0000 е запазен за членове на Fluxer Visionary.';

  @override
  String get storePlutoniumLearnVisionary => 'Научете повече за Visionary.';

  @override
  String get storePlutoniumDonatePrompt =>
      'Искате само да подкрепите разработката на Fluxer с отворен код? ';

  @override
  String get storePlutoniumDonateLink => 'Дарете вместо това.';

  @override
  String get storePlutoniumHighlightsLead =>
      'Абонаментът финансира Fluxer и отключва';

  @override
  String get storePlutoniumHighlightEmoji =>
      'Персонализирани емоджита и стикери във всеки чат';

  @override
  String get storePlutoniumHighlightProfile =>
      'Анимиран профил, значка и избран 4-цифрен номер';

  @override
  String get storePlutoniumHighlightFiles => 'Качвания до 500 MB';

  @override
  String get storePlutoniumHighlightMessages =>
      'Изпращайте съобщения до 4000 знака';

  @override
  String get storePlutoniumHighlightCommunityProfile =>
      'Отделен профил за всяка общност';

  @override
  String get storePlutoniumHighlightsMore => 'И още';

  @override
  String get storePlutoniumRenewsThroughPlay =>
      'Автоматично се подновява през Google Play, докато не го анулирате.';

  @override
  String get storePlutoniumRenewsThroughAppStore =>
      'Автоматично се подновява през App Store, докато не го анулирате.';

  @override
  String get storePlutoniumRestorePurchases => 'Възстановяване на покупките';

  @override
  String get storePlutoniumAlreadySubscribed =>
      'Вече имате абонамент за Fluxer Plutonium.';

  @override
  String storePlutoniumSavePercent(int percent) {
    return 'Спести $percent%';
  }

  @override
  String get storePlutoniumWaiting =>
      'Покупката е получена. Plutonium ще се покаже тук, след като се активира.';

  @override
  String get storePlutoniumUnavailable =>
      'Абонаментите в приложението все още не са налични на това устройство.';

  @override
  String get storePlutoniumVisionaryStatus =>
      'Visionary вече включва постоянен достъп, така че не е необходим повтарящ се абонамент.';

  @override
  String get userSettingsNavPrivacyDashboard => 'Табло за поверителност';

  @override
  String get userSettingsNavAuthorizedApps => 'Оторизирани приложения';

  @override
  String get userSettingsNavBlockedUsers => 'Блокирани потребители';

  @override
  String get userSettingsNavLinkedDevices => 'Свързани устройства';

  @override
  String get userSettingsNavConnections => 'Връзки';

  @override
  String get userSettingsNavLookAndFeel => 'Визия и усещане';

  @override
  String get userSettingsNavAccessibility => 'Достъпност';

  @override
  String get userSettingsNavChat => 'Чат';

  @override
  String get userSettingsNavAudioAndVideo => 'Аудио и видео';

  @override
  String get userSettingsNavShortcuts => 'Клавишни комбинации';

  @override
  String get audioAndVideoAudioSectionTitle => 'Аудио';

  @override
  String get audioAndVideoAudioSectionDescription =>
      'Настройте микрофона, високоговорителите и обработката на гласа си.';

  @override
  String get audioAndVideoVideoSectionTitle => 'Видео';

  @override
  String get audioAndVideoVideoSectionDescription =>
      'Настройте качеството на вашата камера и споделяне на екрана.';

  @override
  String get audioAndVideoInCallBehaviorSectionTitle =>
      'Поведение по време на разговор';

  @override
  String get audioAndVideoInCallBehaviorSectionDescription =>
      'Контролирайте подканите за потвърждение по време на гласови и видео разговори.';

  @override
  String get audioAndVideoInputDeviceLabel => 'Входно устройство';

  @override
  String get audioAndVideoOutputDeviceLabel => 'Изходно устройство';

  @override
  String get audioAndVideoDefaultDeviceLabel => 'По подразбиране';

  @override
  String get audioAndVideoUseSpeakerLabel => 'Използвай високоговорител';

  @override
  String get audioAndVideoUseSpeakerDescription =>
      'Когато е изключено, аудиото се възпроизвежда през слушалката или свързаните слушалки.';

  @override
  String get audioAndVideoInputVolumeLabel => 'Входящ звук';

  @override
  String get audioAndVideoOutputVolumeLabel => 'Изходен звук';

  @override
  String get audioAndVideoVoiceProcessingSectionTitle => 'Обработка на глас';

  @override
  String get audioAndVideoFocusedVoiceLabel => 'Фокусиран глас';

  @override
  String get audioAndVideoFocusedVoiceDescription =>
      'Препоръчително. Изчиства микрофона ви за ясна реч.';

  @override
  String get audioAndVideoDirectInputLabel => 'Директен вход';

  @override
  String get audioAndVideoDirectInputDescription =>
      'Изпраща звука ви без промени. Най-добре е, ако използвате външен аудио софтуер.';

  @override
  String get audioAndVideoCustomProfileLabel => 'По избор';

  @override
  String get audioAndVideoCustomProfileDescription =>
      'Настройте всяка опция сами: потискане на шума, премахване на ехото и усилване.';

  @override
  String get audioAndVideoNoiseSuppressionSectionTitle => 'Потискане на шума';

  @override
  String get audioAndVideoNoiseSuppressionEnhancedLabel => 'Подобрено';

  @override
  String get audioAndVideoNoiseSuppressionStandardLabel => 'Стандартен';

  @override
  String get audioAndVideoNoiseSuppressionNoneLabel => 'Няма';

  @override
  String get audioAndVideoEchoCancellationLabel => 'Потискане на ехото';

  @override
  String get audioAndVideoAutomaticGainControlLabel =>
      'Автоматичен контрол на усилването';

  @override
  String get audioAndVideoAutomaticGainControlDescription =>
      'Изравнява силата на звука на микрофона ви. Изключено, когато е включено подобрено потискане.';

  @override
  String get audioAndVideoMicTestSectionTitle => 'Тест на микрофон';

  @override
  String get audioAndVideoMicTestStartLabel => 'Стартирай тест на микрофона';

  @override
  String get audioAndVideoMicTestStopLabel => 'Спиране на теста на микрофона';

  @override
  String get audioAndVideoCameraLabel => 'Камера';

  @override
  String get audioAndVideoMirrorCameraLabel =>
      'Огледално изображение на камерата';

  @override
  String get audioAndVideoCameraQualitySectionTitle => 'Качество на камерата';

  @override
  String get audioAndVideoCameraQuality480pLabel => '480p';

  @override
  String get audioAndVideoCameraQuality720pLabel => '720p';

  @override
  String get audioAndVideoCameraQuality1080pLabel => '1080p';

  @override
  String get audioAndVideoScreenShareQualitySectionTitle =>
      'Качество на споделяне на екрана';

  @override
  String get audioAndVideoFrameRateSectionTitle => 'Кадрова честота';

  @override
  String get audioAndVideoFrameRate15Label => '15 кадъра/сек';

  @override
  String get audioAndVideoFrameRate30Label => '30 кадъра/сек';

  @override
  String get audioAndVideoFrameRate60Label => '60 кадъра в секунда';

  @override
  String get audioAndVideoInstanceVideoQualityLimit =>
      'Тази инстанция в момента позволява споделяне на екран до 720p при 30 FPS.';

  @override
  String get audioAndVideoSkipHideOwnCameraConfirmLabel =>
      'Не питай, когато скривам камерата си';

  @override
  String get audioAndVideoSkipHideOwnScreenshareConfirmLabel =>
      'Не питай, когато скривам споделянето на екрана си';

  @override
  String get userSettingsNavNotifications => 'Известия';

  @override
  String get notificationsGeneralSectionTitle => 'Общи';

  @override
  String get notificationsEnableNotificationsLabel => 'Включване на известията';

  @override
  String notificationsEnableNotificationsDescription(String productName) {
    return 'Получавайте известия, когато получавате съобщения. Може да се наложи да разрешите известията за $productName в настройките на устройството си. За контроли за всеки канал/общност отворете настройките за известия от менюто на общността.';
  }

  @override
  String get notificationsEnableDesktopNotificationsLabel =>
      'Включване на известия на работния плот';

  @override
  String get notificationsEnableDesktopNotificationsDescription =>
      'Използва центъра за известия на операционната система. За контроли за всеки канал/общност щракнете с десния бутон върху икона на общност и отворете настройките за известия.';

  @override
  String get notificationsPushInactiveTimeoutLabel =>
      'Изчакване при неактивни насочени известия';

  @override
  String notificationsPushInactiveTimeoutDescription(String productName) {
    return '$productName избягва изпращането на известия към мобилните ви устройства, когато сте пред компютъра си. Изберете колко време трябва да бъдете неактивни на работния плот, преди да започнете да получавате известия.';
  }

  @override
  String notificationsPushInactiveTimeoutOneMinute(int oneMinute) {
    return '$oneMinute минута';
  }

  @override
  String notificationsPushInactiveTimeoutMinutes(int minutes) {
    return '$minutes минути';
  }

  @override
  String get notificationsMentionPreferenceSectionTitle =>
      'Предпочитания за споменаване';

  @override
  String get notificationsReplyMentionPreferenceAriaLabel =>
      'Предпочитания за споменаване в отговор';

  @override
  String get notificationsMentionNoPreferenceName => 'Без предпочитания';

  @override
  String get notificationsMentionNoPreferenceDescription =>
      'Зачитане на намерението на подателя, без предупреждение при включване/изключване на споменаването с @';

  @override
  String get notificationsMentionPreferMentionName =>
      'Предпочитам @споменаване';

  @override
  String get notificationsMentionPreferMentionDescription =>
      'По подразбиране отговаря на @споменавания и предупреждава изпращача, ако ги деактивира';

  @override
  String get notificationsMentionPreferNoMentionName =>
      'Без предпочитания за споменаване';

  @override
  String get notificationsMentionPreferNoMentionDescription =>
      'По подразбиране отговорите пропускат @споменаването и предупреждават изпращача, ако го активира';

  @override
  String get notificationsTtsSectionTitle =>
      'Известия чрез преобразуване на текст в реч';

  @override
  String get notificationsTtsEnableCommandLabel =>
      'Включване на /tts възпроизвеждане на говор';

  @override
  String get notificationsTtsEnableCommandDescription =>
      'Нека /tts прочете съобщението ви на глас. Деактивирането на настройката запазва тези команди като обикновен текст.';

  @override
  String get notificationsTtsAccessibilityLinkPrefix =>
      'Регулирайте скоростта на възпроизвеждане в ';

  @override
  String get notificationsTtsAccessibilityLinkLabel => 'Достъпност';

  @override
  String get notificationsTtsAccessibilityLinkSuffix => '.';

  @override
  String get notificationsTtsAutoNarrationTitle =>
      'Автоматично четене на съобщения';

  @override
  String get notificationsTtsAutoNarrationDescription =>
      'Преобразува входящо съдържание в говор, независимо дали е дошло от /tts.';

  @override
  String get notificationsTtsModeAllChannelsName => 'Всеки канал';

  @override
  String get notificationsTtsModeAllChannelsDescription =>
      'Всяко входящо съобщение да се произнася, независимо кой канал е отворен.';

  @override
  String get notificationsTtsModeCurrentChannelName => 'Само за активен канал';

  @override
  String get notificationsTtsModeCurrentChannelDescription =>
      'Разказва само канала, който преглеждате. Разказът ви следва между каналите.';

  @override
  String get notificationsTtsModeNeverName => 'Никога автоматично';

  @override
  String get notificationsTtsModeNeverDescription =>
      'Остава мълчание, освен ако някой не пусне /tts ръчно.';

  @override
  String get notificationsTtsModeAriaLabel =>
      'Прочитай всички съобщения на глас';

  @override
  String get notificationsSoundsSectionTitle => 'Звуци';

  @override
  String get notificationsMasterVolumeLabel => 'Обща сила на звука';

  @override
  String get notificationsMasterVolumeDescription =>
      'Задава нивото на всеки звуков ефект. Настройките за отделни звуци игнорират това.';

  @override
  String get notificationsResetToDefaultVolume =>
      'Възстановяване на силата на звука по подразбиране';

  @override
  String get notificationsDisableAllSoundsLabel =>
      'Изключване на всички звуци за известия';

  @override
  String get notificationsDisableAllSoundsDescription =>
      'Настройките ви за звук на известия ще бъдат запазени.';

  @override
  String get notificationsShowMoreSoundEffects =>
      'Показвай повече звукови ефекти';

  @override
  String get notificationsShowFewerSoundEffects =>
      'Показвай по-малко звукови ефекти';

  @override
  String get notificationsPreviewSound => 'Преглед на звука';

  @override
  String get notificationsPerSoundVolumeTitle => 'Сила на звука за всеки звук';

  @override
  String get notificationsPerSoundVolumeDescription =>
      'Задайте персонализирани нива на звука за отделни звуци. Звуците без персонализирана настройка следват основното ниво на звука.';

  @override
  String notificationsPerSoundVolumeOverrideDescription(int overrideCount) {
    return 'Активни персонализирани настройки за силата на звука: $overrideCount.';
  }

  @override
  String notificationsFollowingMasterVolume(int effectiveValue) {
    return 'Следване на основния • $effectiveValue%';
  }

  @override
  String notificationsResetSoundToMasterVolume(String label) {
    return 'Нулиране на $label до основна сила на звука';
  }

  @override
  String get notificationsResetAllOverrides => 'Нулиране на всички промени';

  @override
  String notificationsMuteSound(String label) {
    return 'Заглушаване на $label.';
  }

  @override
  String notificationsUnmuteSound(String label) {
    return 'Включване на звука за $label.';
  }

  @override
  String get notificationsSoundMessage => 'Известия за съобщения на общността';

  @override
  String get notificationsSoundDirectMessage =>
      'Известия за директни съобщения';

  @override
  String get notificationsSoundSameChannelMessage =>
      'Известия за съобщения от текущия канал';

  @override
  String get notificationsSoundMute => 'Без звук на глас';

  @override
  String get notificationsSoundUnmute => 'Включване на звука';

  @override
  String get notificationsSoundDeaf => 'Изключване на звука в гласов чат';

  @override
  String get notificationsSoundUndeaf => 'Възстановяване на звука в гласов чат';

  @override
  String get notificationsSoundUserJoin =>
      'Потребител се присъединява към канала';

  @override
  String get notificationsSoundUserLeave => 'Потребителят напуска канала';

  @override
  String get notificationsSoundUserMove => 'Потребителят премести канала';

  @override
  String get notificationsSoundViewerJoin =>
      'Зрител се присъединява към потока';

  @override
  String get notificationsSoundViewerLeave => 'Зрителят напуска потока';

  @override
  String get notificationsSoundVoiceDisconnect =>
      'Гласовото повикване е прекъснато';

  @override
  String get notificationsSoundIncomingRing => 'Входящо повикване';

  @override
  String get notificationsSoundCameraOn => 'Камерата е включена';

  @override
  String get notificationsSoundCameraOff => 'Изключена камера';

  @override
  String get notificationsSoundScreenShareStart =>
      'Споделяне на екрана – начало';

  @override
  String get notificationsSoundScreenShareStop =>
      'Спиране на споделянето на екрана';

  @override
  String get notificationsAfkTimeoutSyncFailed =>
      'Не успяхме да актуализираме времето за изчакване на push известията. Опитайте отново.';

  @override
  String get notificationsMentionPreferenceSyncFailed =>
      'Не успях да актуализирам предпочитанията за споменаване. Опитайте отново.';

  @override
  String get notificationsPermissionDeniedTitle => 'Известията са блокирани';

  @override
  String get notificationsEnableNotificationsPermissionDenied =>
      'Не успяхме да активираме известията. Разрешете разрешения за известия, за да продължите.';

  @override
  String get notificationsPushDeliveryProviderLabel =>
      'Доставчик на push известия';

  @override
  String get notificationsPushDeliveryDistributorLabel => 'Дистрибутор';

  @override
  String get notificationsPushDeliveryDistributorNone => 'Не е избран';

  @override
  String get notificationsPushDeliveryDistributorSheetTitle =>
      'Избор на дистрибутор';

  @override
  String get notificationsPushDeliveryDistributorPickAccessibility =>
      'Промяна на дистрибутора на push известия';

  @override
  String get notificationsPushDeliveryGatewayLabel => 'Шлюз';

  @override
  String get notificationsPushDeliveryRelayLabel =>
      'Препредаване echowire Push';

  @override
  String get notificationsPushDeliveryRelayInUse => 'Използва се';

  @override
  String get notificationsPushDeliveryRelayOff => 'Изкл';

  @override
  String get notificationsPushDeliveryRelayNotUsed => 'Не се използва';

  @override
  String get notificationsPushRelaySectionTitle =>
      'Препредаване на push известия';

  @override
  String notificationsPushRelaySectionDescription(String pushProvider) {
    return '$pushProvider доставя push известия само през собствената си услуга, затова известията за това устройство минават през препредаването на Fluxer.';
  }

  @override
  String get notificationsPushRelayConsentLabel =>
      'Използване на push препредаването на Fluxer';

  @override
  String get notificationsPushRelayConsentDescription =>
      'Изключването премахва push регистрацията на това устройство и то спира да получава push известия.';

  @override
  String get pushRelayConsentTitle => 'Препредаване на push известия';

  @override
  String pushRelayConsentDescription(String pushProvider) {
    return '$pushProvider доставя push известия само през собствената си услуга, затова известията за това устройство минават през препредаването на Fluxer.';
  }

  @override
  String get pushRelayConsentNoticePrefix => 'Приемете ';

  @override
  String get pushRelayConsentNoticeLink =>
      'декларацията за поверителност на push препредаването';

  @override
  String get pushRelayConsentNoticeSuffix =>
      ', за да включите push известията на това устройство. Приемането е нужно само веднъж на устройство.';

  @override
  String get pushRelayConsentAgree => 'Приемам и продължавам';

  @override
  String get pushRelayConsentDecline => 'Не сега';

  @override
  String get userSettingsNavLanguageAndTime => 'Език и време';

  @override
  String get languageAndTimeLanguageSectionTitle => 'Език на интерфейса';

  @override
  String get languageAndTimeLanguageSectionDescription =>
      'Изберете езика, който ще се използва в цялото приложение';

  @override
  String get languageAndTimeTimeFormatSectionTitle => 'Формат на часа';

  @override
  String get languageAndTimeTimeFormatSectionDescription =>
      'Изберете как да се показват часовете в приложението';

  @override
  String get languageAndTimeTimeFormatSelectionLabel =>
      'Избор на формат за час';

  @override
  String get languageAndTimeTimeFormatAuto => 'Автоматично';

  @override
  String get languageAndTimeTimeFormat12Hour => '12-часов';

  @override
  String get languageAndTimeTimeFormat24Hour => '24-часов';

  @override
  String languageAndTimeTimeFormatAppLanguage(String format) {
    return 'Език на приложението: $format';
  }

  @override
  String languageAndTimeTimeFormatSystemLocale(String format) {
    return 'Системна локализация: $format';
  }

  @override
  String get languageAndTimeUseSystemLocaleForTimeFormat =>
      'Използване на системните настройки за формат на часа';

  @override
  String get languageAndTimeTimeFormatSyncFailed =>
      'Неуспешно обновяване на формата за час';

  @override
  String get userSettingsNavDefaultApps => 'Приложения по подразбиране';

  @override
  String get defaultAppsWebBrowserSectionTitle => 'Уеб браузър';

  @override
  String get defaultAppsWebBrowserSectionDescription =>
      'Изберете кой браузър да се отваря, когато докоснете връзка.';

  @override
  String get defaultAppsWebBrowserNativeAppNote =>
      'Ако дадено приложение е инсталирано за даден сайт, връзките ще се отварят първо в него.';

  @override
  String get defaultAppsWebBrowserInApp => 'Вграден браузър';

  @override
  String get defaultAppsWebBrowserExternal => 'Външен браузър';

  @override
  String get userSettingsNavAppIcon => 'Икона на приложението';

  @override
  String get appIconSectionTitle => 'Икона на приложението';

  @override
  String get appIconSectionDescription =>
      'Изберете коя икона да се показва на началния ви екран.';

  @override
  String get appIconSectionDescriptionAndroid =>
      'Избери коя икона да се показва на началния ти екран. Смяната на иконата рестартира приложението.';

  @override
  String get appIconAndroidChangeTitle => 'Смяна на иконата на приложението?';

  @override
  String get appIconAndroidChangeDescription =>
      'echowire ще се рестартира, за да приложи новата икона на началния екран.';

  @override
  String get appIconAndroidChangeConfirm => 'Смяна на икона';

  @override
  String get appIconOptionDefault => 'По подразбиране';

  @override
  String get appIconOptionStarfield => 'Звездно поле';

  @override
  String get appIconOptionSweden => 'Швеция';

  @override
  String get appIconOptionGreyscale => 'Сиви тонове';

  @override
  String get appIconOptionRainbow => 'Дъга';

  @override
  String get appIconOptionWaves => 'Вълни';

  @override
  String get appIconOptionChromaticAberration => 'Хроматична аберация';

  @override
  String get appIconOptionDefaultBrutalist => 'Бруталистична';

  @override
  String get appIconOptionGreyscaleBrutalist => 'Бруталистична в сиви тонове';

  @override
  String get appIconUnsupported =>
      'Смяната на иконата на приложението не е налична на това устройство.';

  @override
  String get userSettingsNavAdvanced => 'Разширени';

  @override
  String get advancedPerformanceReportingTitle =>
      'Докладване на производителността';

  @override
  String get advancedCrashReportingSectionDescription =>
      'Помогни на echowire да оправя грешки в това приложение, като споделяш данни за сривове и производителност. По подразбиране това е изключено.';

  @override
  String get advancedPerformanceReportingLabel =>
      'Изпращане на отчети за сривове и производителност';

  @override
  String get advancedCrashReportingDescription =>
      'Отчетите отиват в системата за проследяване на грешки на echowire, дори когато си влязъл в друга инстанция. Те не съдържат имена на инстанции, идентификатори или съдържание на съобщения.';

  @override
  String get observabilityReportingConsentTitle =>
      'Помогни да оправим сривовете';

  @override
  String get observabilityReportingConsentSubtitle =>
      'echowire се затвори неочаквано. Споделянето на анонимни данни за сривове и грешки ни помага да оправяме проблемите по-бързо.';

  @override
  String get observabilityReportingConsentBody =>
      'Отчетите съдържат журнали на сривове, грешки и основни данни за производителността. Те не се споделят с трети страни и можеш да изключиш това по всяко време.';

  @override
  String observabilityReportingConsentEnableLater(String reportingToggle) {
    return 'За да го включиш по-късно, отвори Настройки → Разширени → $reportingToggle.';
  }

  @override
  String get observabilityReportingConsentAgree =>
      'Изпращане на отчети за сривове';

  @override
  String get observabilityReportingConsentDecline => 'Не искам да включвам';

  @override
  String get advancedSettingsConfigure => 'Конфигуриране';

  @override
  String get advancedSettingsCategoryPrivacy => 'Поверителност';

  @override
  String get advancedSettingsCategoryAppearance => 'Външен вид';

  @override
  String get advancedSettingsCategoryAccessibility => 'Достъпност';

  @override
  String get advancedSettingsCategoryChat => 'Чат';

  @override
  String get advancedSettingsCategoryMedia => 'Медия';

  @override
  String get advancedSettingsCategoryVoice => 'Гласово';

  @override
  String get advancedSettingsCategoryDeveloper => 'Разработчик';

  @override
  String get advancedSettingEnableTextSelectionLabel =>
      'Разрешаване на избиране на текст';

  @override
  String get advancedSettingEnableTextSelectionDescription =>
      'Позволява избиране на текст в приложението.';

  @override
  String get advancedSettingVideoSeekThumbnailsLabel =>
      'Активиране на миниатюрите за преглед при търсене във видеото';

  @override
  String get advancedSettingVideoSeekThumbnailsDescription =>
      'Миниатюра или кадър на живо, докато превъртате видео.';

  @override
  String get advancedSettingHapticFeedbackLabel => 'Хаптична обратна връзка';

  @override
  String get advancedSettingHapticFeedbackDescription =>
      'Вибрационна обратна връзка при докосване и действия. Няма да се синхронизира между устройствата.';

  @override
  String get advancedSettingShowNekoLabel => 'Показване на Pickles';

  @override
  String get advancedSettingShowNekoDescription =>
      'Котката Pickles, която гони курсора ви';

  @override
  String get advancedSettingShowNekoDescriptionTouch =>
      'Покажи Pickles в полето за въвеждане на чат';

  @override
  String get advancedSettingMobileSplashZoomAnimationLabel =>
      'Анимация при мащабиране при стартиране';

  @override
  String get advancedSettingMobileSplashZoomAnimationDescription =>
      'Намали мащаба на логото при излизане от началния екран';

  @override
  String get advancedSettingSplashQuotesLabel => 'Splash screen quotes';

  @override
  String get advancedSettingSplashQuotesDescription =>
      'Show a random quote on the splash screen. Won\'t sync across devices.';

  @override
  String get advancedSettingKeyboardHintsLabel => 'Подсказки за клавиатурата';

  @override
  String get advancedSettingKeyboardHintsDescription =>
      'Показване на съвети за клавишни комбинации в подсказките.';

  @override
  String get advancedSettingEnableFavoritesLabel => 'Разрешаване на любими';

  @override
  String get advancedSettingEnableFavoritesDescription =>
      'Показвай любимите навсякъде в приложението.';

  @override
  String get advancedSettingVoiceChannelJoinBehaviorLabel =>
      'Поведение при присъединяване към гласов канал';

  @override
  String get advancedSettingVoiceChannelJoinBehaviorDescription =>
      'Потвърждение или двойно щракване при включване във гласов канал.';

  @override
  String get advancedSettingRequireDoubleClickJoinLabel =>
      'Изискване на двойно щракване за присъединяване към гласови канали';

  @override
  String get advancedSettingConfirmBeforeJoiningVoiceLabel =>
      'Потвърждаване преди присъединяване към гласови канали';

  @override
  String get advancedSettingAutoSendGifsLabel =>
      'Автоматично изпращане на GIF файлове при избиране';

  @override
  String get advancedSettingAutoSendGifsDescription =>
      'Автоматично изпращане на GIF файлове от галерията без потвърждение';

  @override
  String get advancedSettingSaveGifFavoritesLabel =>
      'Запазване на любими GIF файлове като запазени медии';

  @override
  String get advancedSettingSaveGifFavoritesDescription =>
      'Изберете как да се съхраняват любимите анимирани GIF файлове';

  @override
  String get advancedSettingMediaButtonsLabel => 'Медийни бутони';

  @override
  String get advancedSettingMediaButtonsDescription =>
      'Персонализирайте кои бутони и индикатори да се показват върху прикачени файлове и вградени елементи';

  @override
  String get advancedSettingPreuploadAttachmentsLabel =>
      'Качвайте прикачени файлове преди изпращане';

  @override
  String get advancedSettingPreuploadAttachmentsDescription =>
      'Започнете да качвате прикачени файлове веднага след като бъдат добавени към полето за въвеждане на съобщение';

  @override
  String get advancedSettingStripTrackingLabel =>
      'Премахване на параметри за проследяване от URL адреси';

  @override
  String get advancedSettingStripTrackingDescription =>
      'Автоматично премахване на параметри за проследяване от URL адреси в съобщения, които изпращате';

  @override
  String get advancedSettingTrustAllLinksLabel =>
      'Доверяване на всички външни връзки';

  @override
  String get advancedSettingSearchEnginesLabel => 'Търсачки';

  @override
  String get advancedSettingSearchEnginesDescription =>
      'Конфигуриране на търсачките, които се използват за избрания текст';

  @override
  String get advancedSettingTranslatorsLabel => 'Преводачи';

  @override
  String get advancedSettingTranslatorsDescription =>
      'Конфигуриране на преводаческите услуги, използвани за избран текст';

  @override
  String get advancedSettingReverseImageSearchLabel => 'Търсене по изображение';

  @override
  String get advancedSettingReverseImageSearchDescription =>
      'Доставчици на услуги за обратно търсене на изображения.';

  @override
  String get advancedSettingMessageActionBarLabel =>
      'Лента с действия за съобщения';

  @override
  String get advancedSettingMessageActionBarDescription =>
      'Персонализиране на лентата с действия, която се показва при задържане на курсора върху съобщения';

  @override
  String get advancedSettingExpressionAutocompleteLabel =>
      'Автоматично довършване на изрази';

  @override
  String get advancedSettingExpressionAutocompleteDescription =>
      'Изберете какво се показва, когато напишете двоеточие в полето за въвеждане на съобщение';

  @override
  String get advancedSettingInputButtonsLabel =>
      'Бутони за въвеждане на съобщения';

  @override
  String get advancedSettingInputButtonsDescription =>
      'Изберете кои бутони да се показват в полето за въвеждане на съобщения';

  @override
  String get advancedSettingScrollToBottomOnSendLabel =>
      'Превъртане до долу при изпращане на съобщение';

  @override
  String get advancedSettingScrollToBottomOnSendDescription =>
      'Изберете какво да се случва с чата след изпращане на съобщение';

  @override
  String get advancedSettingSkipMarkAllAsReadLabel =>
      'Пропускане на потвърждението за \"Маркиране на всички като прочетени\"';

  @override
  String get advancedSettingSkipMarkAllAsReadDescription =>
      'Маркирай всички непрочетени канали във входящата кутия като прочетени веднага, без да питаш за потвърждение';

  @override
  String get advancedSettingHideMutedChannelsLabel =>
      'Скрий заглушените канали по подразбиране';

  @override
  String get advancedSettingHideMutedChannelsDescription =>
      'Скриване на заглушени канали от страничните ленти на общността';

  @override
  String get advancedSettingShowGifIndicatorLabel =>
      'Показване на индикатор за GIF';

  @override
  String get advancedSettingShowAttachmentExpiryLabel =>
      'Показване на индикатор за изтичане на прикачен файл';

  @override
  String get advancedSettingShowMediaDeleteLabel =>
      'Показване на бутон за изтриване';

  @override
  String get advancedSettingShowMediaDownloadLabel =>
      'Показване на бутон за изтегляне';

  @override
  String get advancedSettingShowMediaFavoriteLabel =>
      'Показване на бутон \"Любими\"';

  @override
  String get advancedSettingShowSuppressEmbedsLabel =>
      'Показване на бутон за потискане на вградени елементи';

  @override
  String get advancedSettingShowMessageActionBarLabel =>
      'Показване на лентата с действия за съобщения';

  @override
  String get advancedSettingShowOnlyMoreButtonLabel =>
      'Показване само на бутона \"Още\"';

  @override
  String get advancedSettingShowQuickReactionsLabel =>
      'Показване на бързи реакции';

  @override
  String get advancedSettingEnableShiftToExpandLabel =>
      'Разгъване при натискане на Shift';

  @override
  String get advancedSettingShowDefaultEmojisAutocompleteLabel =>
      'Показване на стандартни емоджита в автоматичното довършване на изрази';

  @override
  String get advancedSettingShowCustomEmojisAutocompleteLabel =>
      'Показване на персонализирани емоджита в автоматичното довършване на изрази';

  @override
  String get advancedSettingShowStickersAutocompleteLabel =>
      'Показване на стикери при автоматично довършване на изрази';

  @override
  String get advancedSettingShowSavedMediaAutocompleteLabel =>
      'Показване на запазени медии в предложенията за изразяване';

  @override
  String get advancedSettingShowGifsButtonLabel =>
      'Показване на бутон за GIF файлове';

  @override
  String get advancedSettingShowMediaButtonLabel =>
      'Показване на бутон за медия';

  @override
  String get advancedSettingShowStickersButtonLabel =>
      'Показване на бутона за стикери';

  @override
  String get advancedSettingShowEmojiButtonLabel =>
      'Показване на бутона за емоджита';

  @override
  String get advancedSettingShowSendButtonLabel =>
      'Показване на бутона за изпращане';

  @override
  String get advancedSettingNewDeviceAlertsLabel =>
      'Показване на известия за нови устройства';

  @override
  String get advancedSettingNewDeviceAlertsDescription =>
      'Показване на подкана за нови аудио устройства.';

  @override
  String get advancedSettingConnectionVolumeControlsLabel =>
      'Контрол на силата на звука при връзка';

  @override
  String get advancedSettingConnectionVolumeControlsDescription =>
      'Показване на плъзгачи за силата на звука на участниците за всяко устройство в гласовите менюта';

  @override
  String get advancedSettingScreenSharePreviewBehaviorLabel =>
      'Поведение при преглед на споделянето на екрана';

  @override
  String get advancedSettingScreenSharePreviewBehaviorDescription =>
      'Предварителен преглед, изскачащо прозорче и поведение на миниатюрата при стрийминг.';

  @override
  String get advancedSettingScreenShareCodecLabel =>
      'Кодек за споделяне на екран';

  @override
  String get advancedSettingScreenShareCodecDescription =>
      'Видео кодек за споделяне на екрана.';

  @override
  String get advancedSettingScreenShareCodecAuto =>
      'Автоматично (препоръчително)';

  @override
  String get advancedSettingScreenShareCodecAv1 => 'AV1';

  @override
  String get advancedSettingScreenShareCodecH265 => 'H.265';

  @override
  String get advancedSettingScreenShareCodecVp9 => 'VP9';

  @override
  String get advancedSettingScreenShareCodecH264 => 'H.264';

  @override
  String get advancedSettingScreenShareCodecVp8 => 'VP8';

  @override
  String get advancedSettingPauseScreenSharePreviewLabel =>
      'Постави на пауза прегледа на споделения ми екран във фонов режим';

  @override
  String get advancedSettingHideStreamPreviewLabel =>
      'Скрий миниатюрата за предварителен преглед на моя поток';

  @override
  String get advancedSettingDeveloperModeLabel =>
      'Включване на режим за разработчици';

  @override
  String get advancedSettingDeveloperModeDescription =>
      'Включване на режим за разработчици';

  @override
  String get advancedSettingDefaultSearchEngineLabel =>
      'Търсачка по подразбиране';

  @override
  String get advancedSettingDefaultSearchEngineDescription =>
      'Изберете коя търсачка да се използва по подразбиране при търсене на избран текст.';

  @override
  String get advancedSettingBuiltInSearchEnginesLabel => 'Вградени търсачки';

  @override
  String get advancedSettingBuiltInSearchEnginesDescription =>
      'Активирайте или деактивирайте вградените търсачки. Активираните търсачки се показват в контекстното меню на съобщението, когато е избран текст.';

  @override
  String get advancedSettingCustomSearchEnginesLabel =>
      'Персонализирани търсачки';

  @override
  String advancedSettingCustomSearchEnginesDescription(Object query) {
    return 'Добавете собствени търсачки с персонализиран URL шаблон. Използвайте „$query“ като заместител на текста за търсене.';
  }

  @override
  String get advancedSettingAddSearchEngineLabel => 'Добавяне на търсачка';

  @override
  String get advancedSettingEnableAtLeastOneSearchEngineLabel =>
      'Активирайте поне една търсачка по-долу.';

  @override
  String get advancedSettingRemoveSearchEngineLabel => 'Премахване на търсачка';

  @override
  String get advancedSettingDefaultTranslatorLabel =>
      'Преводач по подразбиране';

  @override
  String get advancedSettingDefaultTranslatorDescription =>
      'Изберете кой преводач да се използва по подразбиране при превод на избран текст.';

  @override
  String get advancedSettingBuiltInTranslatorsLabel => 'Вградени преводачи';

  @override
  String get advancedSettingBuiltInTranslatorsDescription =>
      'Включете или изключете вградените преводачи. Активираните преводачи се показват в контекстното меню на съобщението, когато е избран текст.';

  @override
  String get advancedSettingCustomTranslatorsLabel =>
      'Персонализирани преводачи';

  @override
  String advancedSettingCustomTranslatorsDescription(Object query) {
    return 'Добавете свои собствени преводачи с персонализиран URL шаблон. Използвайте \'$query\' като заместител на текста за превод.';
  }

  @override
  String get advancedSettingAddTranslatorLabel => 'Добавяне на преводач';

  @override
  String get advancedSettingEnableAtLeastOneTranslatorLabel =>
      'Активирайте поне един преводач по-долу.';

  @override
  String get advancedSettingRemoveTranslatorLabel => 'Премахване на преводача';

  @override
  String get advancedSettingDefaultReverseImageSearchLabel =>
      'Търсене по изображение по подразбиране';

  @override
  String get advancedSettingDefaultReverseImageSearchDescription =>
      'Изберете коя услуга за обратно търсене на изображения да се използва по подразбиране, когато търсите изображение.';

  @override
  String get advancedSettingBuiltInReverseImageSearchLabel =>
      'Вградено търсене по изображение';

  @override
  String get advancedSettingBuiltInReverseImageSearchDescription =>
      'Активирайте или деактивирайте вградените доставчици за обратно търсене на изображения. Активираните доставчици се показват в контекстното меню на изображения, аватари, банери, стикери и емотикони.';

  @override
  String get advancedSettingCustomReverseImageSearchLabel =>
      'Търсене по изображение';

  @override
  String advancedSettingCustomReverseImageSearchDescription(Object url) {
    return 'Добавете свои собствени доставчици за търсене по изображение с персонализиран шаблон за URL адрес. Използвайте \'$url\' като заместител на URL адреса на изображението.';
  }

  @override
  String get advancedSettingAddReverseImageSearchLabel =>
      'Добавяне на обратно търсене на изображения';

  @override
  String get advancedSettingEnableAtLeastOneReverseImageSearchLabel =>
      'Активирайте поне един доставчик на обратно търсене на изображения по-долу.';

  @override
  String get advancedSettingRemoveReverseImageSearchLabel =>
      'Премахване на обратно търсене на изображения';

  @override
  String get advancedSettingAddSearchEngineTitle => 'Добавяне на търсачка';

  @override
  String get advancedSettingEditSearchEngineTitle => 'Редактиране на търсачка';

  @override
  String get advancedSettingAddTranslatorTitle =>
      'Добавяне на доставчик на преводи';

  @override
  String get advancedSettingEditTranslatorTitle =>
      'Редактиране на доставчик на преводи';

  @override
  String get advancedSettingAddReverseImageSearchTitle =>
      'Добавяне на търсачка за обратно търсене на изображения';

  @override
  String get advancedSettingEditReverseImageSearchTitle =>
      'Редактиране на търсачка за обратно търсене на изображения';

  @override
  String get advancedSettingSearchProviderNameLabel => 'Име';

  @override
  String get advancedSettingSearchProviderUrlLabel => 'URL шаблон';

  @override
  String get advancedSettingSearchProviderNameTextPlaceholder =>
      'Моята търсачка';

  @override
  String get advancedSettingSearchProviderNameTranslatePlaceholder =>
      'Моят преводач';

  @override
  String get advancedSettingSearchProviderNameImagePlaceholder =>
      'Моето търсене по изображение';

  @override
  String advancedSettingSearchProviderUrlTextHint(Object query) {
    return 'Използвайте \'$query\', където трябва да се постави текстът за търсене.';
  }

  @override
  String advancedSettingSearchProviderUrlTranslateHint(Object query) {
    return 'Използвайте „$query“, където трябва да се постави текстът за превод.';
  }

  @override
  String advancedSettingSearchProviderUrlImageHint(Object url) {
    return 'Използвайте \'$url\', където трябва да се постави URL адресът на изображението.';
  }

  @override
  String get advancedSettingSearchProviderNameRequired =>
      'Името е задължително.';

  @override
  String get advancedSettingSearchProviderUrlRequired =>
      'Изисква се URL шаблон.';

  @override
  String advancedSettingSearchProviderUrlMustContainQuery(Object query) {
    return 'URL шаблонът трябва да съдържа плейсхолдъра „$query“.';
  }

  @override
  String advancedSettingSearchProviderUrlMustContainUrl(Object url) {
    return 'URL шаблонът трябва да съдържа плейсхолдър \"$url\".';
  }

  @override
  String get advancedSettingSearchProviderUrlMustBeValid =>
      'URL шаблонът трябва да е валиден URL адрес.';

  @override
  String get advancedSettingAddSearchProviderAction => 'Добавяне';

  @override
  String get advancedSettingEditSearchProviderAction => 'Редактиране';

  @override
  String get advancedSettingRemoveSearchProviderConfirmAction => 'Премахване';

  @override
  String advancedSettingRemoveSearchProviderConfirmDescription(
    String engineName,
  ) {
    return 'Сигурни ли сте, че искате да премахнете $engineName?';
  }

  @override
  String get userSettingsNavApplications => 'Приложения';

  @override
  String get userSettingsNavAppLogs => 'Дневници на приложението';

  @override
  String get userSettingsNavDeveloperTools => 'Инструменти за разработчици';

  @override
  String get userSettingsNavLimitsConfig => 'Конфигурация на лимити';

  @override
  String get userSettingsNavFeatureFlags => 'Знамена на функции';

  @override
  String get userSettingsNavWhatsNew => 'Какво ново';

  @override
  String get userSettingsJoinFluxerLabs => 'Присъединете се към Fluxer Labs';

  @override
  String get userSettingsGiveFeedback => 'Изпрати отзив';

  @override
  String get userSettingsNavAppLicenses => 'Лицензи на приложения';

  @override
  String get userSettingsAppLicensesDescription =>
      'Софтуер с отворен код, използван от това приложение. Това приложение е изградено с Flutter.';

  @override
  String get userSettingsAppLicensesLoadError =>
      'Не успяхме да заредим лицензите за приложенията.';

  @override
  String userSettingsAppLicensesPackageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count лиценза',
      one: '1 лиценз',
    );
    return '$_temp0';
  }

  @override
  String get userSettingsNavLogOut => 'Изход';

  @override
  String get userSettingsLogOutConfirmTitle => 'Да излезеш ли?';

  @override
  String get userSettingsLogOutConfirmDescription =>
      'Можеш да влезеш отново по всяко време.';

  @override
  String get quickSwitcherTabSearch => 'Търсене';

  @override
  String get quickSwitcherTabFriends => 'Приятели';

  @override
  String get quickSwitcherSearchPlaceholder =>
      'Търсене на канали, хора или общности';

  @override
  String get quickSwitcherSearchFriends => 'Търсене на приятели';

  @override
  String get quickSwitcherNoMatchesFound => 'Няма намерени съвпадения';

  @override
  String get quickSwitcherEmptyHint =>
      'Опитайте друго име или използвайте префиксите @ / # / ! / *, за да филтрирате резултатите.';

  @override
  String get quickSwitcherSectionPeople => 'Хора';

  @override
  String get quickSwitcherSectionGroupMessages => 'Съобщения от групи';

  @override
  String get quickSwitcherSectionTextChannels => 'Текстови канали';

  @override
  String get quickSwitcherSectionThreads => 'Нишки';

  @override
  String get quickSwitcherSectionVoiceChannels => 'Гласови канали';

  @override
  String get quickSwitcherSectionCommunities => 'Общности';

  @override
  String get quickSwitcherSectionSettings => 'Настройки';

  @override
  String get quickSwitcherHomeLabel => 'Начало';

  @override
  String get quickSwitcherDirectMessagesLabel => 'Лични съобщения';

  @override
  String get quickSwitcherFavoritesLabel => 'Любими';

  @override
  String get quickSwitcherUserSettingsLabel => 'Потребителски настройки';

  @override
  String get quickSwitcherNotificationsLabel => 'Известия';

  @override
  String get quickSwitcherBookmarksLabel => 'Отметки';

  @override
  String get savedMessagesEmptyTitle => 'Няма отметки';

  @override
  String get savedMessagesEmptyBody =>
      'Запазете съобщения, за да ги прочетете по-късно.';

  @override
  String get savedMessagesEndBody => 'Няма какво друго да видите тук.';

  @override
  String get savedMessagesRemoveTooltip => 'Премахване от отметки';

  @override
  String get savedMessagesAddedToast => 'Добавено към отметки';

  @override
  String get savedMessagesRemovedToast => 'Премахнато от отметки';

  @override
  String get quickSwitcherMentionsLabel => 'Споменавания';

  @override
  String get quickSwitcherFriendsEmptyTitle => 'Все още нямате приятели';

  @override
  String get quickSwitcherFriendsEmptyHint =>
      'Добавете приятел, за да започнете.';

  @override
  String get quickSwitcherFriendsNoMatchTitle =>
      'Няма приятели, които да отговарят на търсенето';

  @override
  String get quickSwitcherFriendsNoMatchHint => 'Опитайте друго име.';

  @override
  String get quickSwitcherSearchAliasUser => 'Потребител';

  @override
  String get quickSwitcherSearchAliasYou => 'Вие';

  @override
  String get quickSwitcherSearchAliasDm => 'ЛС';

  @override
  String get quickSwitcherSearchAliasDms => 'Лични съобщения';

  @override
  String get quickSwitcherSearchAliasMessages => 'Съобщения';

  @override
  String get quickSwitcherSearchAliasFav => 'Любими';

  @override
  String get quickSwitcherSearchAliasStarred => 'С любими';

  @override
  String get quickSwitcherSearchAliasInbox => 'Входящи';

  @override
  String get quickSwitcherSearchAliasSaved => 'Запазено';

  @override
  String get uiClose => 'Затвори';

  @override
  String get chatJumpToBottom => 'Премини към дъното';

  @override
  String get chatUnreadDividerNew => 'Нови';

  @override
  String get uiConfirm => 'Потвърди';

  @override
  String get uiUnderstood => 'Разбрано';

  @override
  String get uiLoading => 'Зареждане';

  @override
  String get uiSearch => 'Търсене';

  @override
  String get uiStartCall => 'Започване на разговор';

  @override
  String get uiStartVideoCall => 'Започване на видео разговор';

  @override
  String get uiPlay => 'Пусни';

  @override
  String get uiPause => 'Пауза';

  @override
  String get uiDownload => 'Изтегляне';

  @override
  String get uiMoreActions => 'Още действия';

  @override
  String get uiUnsavedChanges => 'Незапазени промени';

  @override
  String get uiReset => 'Нулиране';

  @override
  String get uiOpenColorPicker => 'Отваряне на палитрата с цветове';

  @override
  String get uiSelectPlaceholder => 'Избери';

  @override
  String get uiSearchPlaceholder => 'Търсене';

  @override
  String get uiNoOptionsFound => 'Не са намерени опции';

  @override
  String get uiDismissNotification => 'Затвори известие';

  @override
  String get uiColorPickerTitle => 'Избор на цвят';

  @override
  String get mentionConfirmTitle => 'Споменаване на всички?';

  @override
  String mentionConfirmEveryoneBody(int count) {
    return 'Това ще извести $count членове. Да продължим?';
  }

  @override
  String mentionConfirmHereBody(int count) {
    return 'Това ще уведоми $count онлайн членове. Продължаване?';
  }

  @override
  String mentionConfirmRoleBody(int count, String roleName) {
    return 'Това ще извести $count членове с ролята $roleName. Да продължим?';
  }

  @override
  String get mentionConfirmButton => 'Споменаване';

  @override
  String get composerEmojiUnavailable =>
      'Не можеш да използваш този емотикон тук.';

  @override
  String get instanceUrlLabel => 'URL на инстанцията';

  @override
  String get instanceUrlPlaceholder =>
      'Въведете URL на инстанцията (напр. echowire.org)';

  @override
  String get instanceUrlHelper =>
      'Използвайте echowire.org за официалния инстанс или точния URL адрес на самохостван инстанс.';

  @override
  String get resetToDefaultInstance => 'Възстановяване до echowire';

  @override
  String get instanceConnect => 'Свързване';

  @override
  String get instanceConnecting => 'Свързване…';

  @override
  String get instanceConnectFailed => 'Неуспешно свързване към инстанция';

  @override
  String instanceConnectFailedDomain(String domain) {
    return 'Не успяхме да се свържем с $domain. Опитай отново.';
  }

  @override
  String get instanceInvalidDiscoveryResponse =>
      'Не успяхме да прочетем конфигурацията на тази инстанция. Провери адреса и опитай отново.';

  @override
  String instanceOutdatedForClient(String domain) {
    return 'Тази инстанция е твърде стара за това приложение. Помоли администратора на $domain да обнови echowire.';
  }

  @override
  String instanceRequiresNewerClient(String domain) {
    return '$domain използва по-нова версия на echowire от това приложение. Обнови приложението и опитай отново.';
  }

  @override
  String get instanceCompatibilityTitle =>
      'Тази инстанция не може да се използва';

  @override
  String get instanceCompatibilityRetry => 'Опитай отново';

  @override
  String get instanceCompatibilityUpdateApp => 'Актуализиране на приложението';

  @override
  String get instanceCompatibilityStatusPagePrompt =>
      'Провери страницата за състоянието за новини.';

  @override
  String get instanceCompatibilityStatusPageLink => 'страница за състоянието';

  @override
  String get recentInstances => 'Последни инстанции';

  @override
  String removeRecentInstance(String domain) {
    return 'Премахни $domain от последните инстанции';
  }

  @override
  String get instanceSheetTitle => 'Свързване към инстанция';

  @override
  String get changeInstance => 'Промяна';

  @override
  String get instanceConnectionRequired =>
      'Свържете се с инстанцията, за да влезете';

  @override
  String get comingSoon => 'Очаквайте скоро';

  @override
  String get guildNavbarDirectMessages => 'Лични съобщения';

  @override
  String get guildNavbarExploreDiscoverableCommunities => 'Разгледай общности';

  @override
  String get discoveryExplore => 'Разглеждане';

  @override
  String get discoveryExplorePublicCommunities =>
      'Разгледайте публични общности';

  @override
  String get discoveryListingSubheading =>
      'Искате да включите вашата общност тук? Кандидатствайте, ако отговаряте на изискванията в настройките на вашата общност > Разглеждане.';

  @override
  String get discoverySearchCommunities => 'Търсене на общности';

  @override
  String get discoveryFilterByLanguage => 'Филтриране по език';

  @override
  String get discoveryAllLanguages => 'Всички езици';

  @override
  String get discoveryAllCategories => 'Всички';

  @override
  String get discoveryCategoryGaming => 'Игри';

  @override
  String get discoveryCategoryMusic => 'Музика';

  @override
  String get discoveryCategoryEntertainment => 'Развлечения';

  @override
  String get discoveryCategoryEducation => 'Образование';

  @override
  String get discoveryCategoryScienceAndTechnology => 'Наука и технологии';

  @override
  String get discoveryCategoryContentCreator => 'Създател на съдържание';

  @override
  String get discoveryCategoryAnimeAndManga => 'Аниме и манга';

  @override
  String get discoveryCategoryMoviesAndTv => 'Филми и телевизия';

  @override
  String get discoveryCategoryOther => 'Друго';

  @override
  String get discoveryNoCommunitiesMatch => 'Няма съвпадащи общности.';

  @override
  String get discoveryJoinCommunity => 'Присъединяване към общността';

  @override
  String get discoveryJoined => 'Присъединих се';

  @override
  String discoveryOnlineCount(String count) {
    return '$count онлайн';
  }

  @override
  String discoveryMemberCount(num count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString членове',
      one: '1 член',
    );
    return '$_temp0';
  }

  @override
  String get discoveryNoDescription => 'Няма описание.';

  @override
  String get discoveryCommunities => 'Общности';

  @override
  String get discoveryApps => 'Приложения';

  @override
  String get discoveryJoinErrorGenericTitle =>
      'Неуспешно присъединяване към общността';

  @override
  String get discoveryJoinErrorGenericMessage =>
      'Нещо се обърка. Моля, опитайте отново след малко.';

  @override
  String get discoveryJoinErrorFullTitle => 'Тази общност е пълна';

  @override
  String get discoveryJoinErrorFullMessage =>
      'Тази общност е достигнала лимита си за членове, така че не можете да се присъедините в момента.';

  @override
  String get discoveryJoinErrorMaxGuildsTitle =>
      'Достигнали сте лимита за общности';

  @override
  String get discoveryJoinErrorMaxGuildsMessage =>
      'Вече сте в максималния брой общности. Напуснете една и опитайте отново.';

  @override
  String get discoveryJoinErrorBannedTitle =>
      'Не можеш да се присъединиш към тази общност';

  @override
  String get discoveryJoinErrorBannedMessage =>
      'Блокирани сте от тази общност.';

  @override
  String get discoveryJoinErrorNotAvailableTitle =>
      'Тази общност вече не е налична';

  @override
  String get discoveryJoinErrorNotAvailableMessage =>
      'Може да е напуснала „Разглеждане“ или да е изключила новите присъединявания. Презареди страницата и няма да я виждаш повече.';

  @override
  String get discoveryJoinErrorRateLimitTitle => 'Действате твърде бързо';

  @override
  String get discoveryJoinErrorRateLimitMessage =>
      'Моля, изчакайте малко и опитайте отново.';

  @override
  String get guildNavbarAddCommunity => 'Добави общност';

  @override
  String get guildNavbarHelp => 'Помощ';

  @override
  String get scrollIndicatorNew => 'Ново';

  @override
  String get scrollIndicatorNewMessages => 'Нови съобщения';

  @override
  String guildNavbarCollapseFolder(String folderName) {
    return 'Свиване на $folderName';
  }

  @override
  String get guildNavbarGuildSelected => 'избрано';

  @override
  String get guildNavbarGuildUnread => 'непрочетени';

  @override
  String guildNavbarGuildMentions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count споменавания',
      one: '1 споменаване',
    );
    return '$_temp0';
  }

  @override
  String get navigationItemMuted => 'скрито';

  @override
  String get authShowPassword => 'Покажи паролата';

  @override
  String get authHidePassword => 'Скрий паролата';

  @override
  String get authCheckStillWorking => 'Все още работим по въпроса…';

  @override
  String get authVerificationFailed =>
      'Неуспешно завършване на проверката. Опитайте отново.';

  @override
  String get chatLoadingMessages => 'Зареждане на съобщения';

  @override
  String get friendsMessageFriend => 'Изпрати съобщение';

  @override
  String get friendsFriendActions => 'Действия с приятел';

  @override
  String get friendsAcceptRequest => 'Приемане на покана за приятелство';

  @override
  String get friendsDeclineRequest => 'Отхвърли заявката за приятелство';

  @override
  String get friendsCancelRequest => 'Отказване на покана за приятелство';

  @override
  String get friendsOpenInbox => 'Входящи';

  @override
  String get profileRemoveFriend => 'Премахване от приятели';

  @override
  String get profileUnblockUser => 'Деблокиране на потребител';

  @override
  String get profileAcceptFriendRequest => 'Приемане на покана за приятелство';

  @override
  String get profileCancelFriendRequest => 'Отказване на покана за приятелство';

  @override
  String get profileSendFriendRequest => 'Изпращане на покана за приятелство';

  @override
  String get accountOverflowMenu => 'Опции на профила';

  @override
  String get navHome => 'Начало';

  @override
  String get navNotifications => 'Известия';

  @override
  String get navYou => 'Вие';

  @override
  String get guildFolderSettingsTitle => 'Настройки на папката';

  @override
  String get guildFolderNameLabel => 'Име на папката';

  @override
  String get guildFolderColorLabel => 'Цвят на папката';

  @override
  String get guildFolderShowIconWhenCollapsed =>
      'Показване на икона при свиване';

  @override
  String get guildFolderIconLabel => 'Икона на папка';

  @override
  String get guildFolderDelete => 'Изтриване на папка';

  @override
  String get guildFolderIconFolder => 'Папка';

  @override
  String get guildFolderIconStar => 'Звезда';

  @override
  String get guildFolderIconHeart => 'Сърце';

  @override
  String get guildFolderIconBookmark => 'Отметка';

  @override
  String get guildFolderIconGameController => 'Геймпад';

  @override
  String get guildFolderIconShield => 'Защита';

  @override
  String get guildFolderIconMusicNote => 'Музикална нота';

  @override
  String get guildFolderMarkAsRead => 'Маркирай папката като прочетена';

  @override
  String get guildBulkMuteCommunities => 'Изключване на общности';

  @override
  String get guildBulkUnmuteCommunities => 'Включване на звука на общностите';

  @override
  String get guildBulkCommunityNotificationSettings =>
      'Настройки за известия на общността';

  @override
  String get guildBulkCommunityPrivacySettings =>
      'Настройки за поверителност на общността';

  @override
  String get guildBulkAllowEveryoneAndHere => 'Разреши @everyone и @here';

  @override
  String get guildBulkAllowRoleMentions =>
      'Разрешаване на споменавания на роли';

  @override
  String get guildBulkEnableMobilePush => 'Включване на мобилни известия';

  @override
  String get guildBulkDisableMobilePush => 'Изключване на мобилни известия';

  @override
  String get guildBulkAllowDirectMessages =>
      'Разрешаване на директни съобщения';

  @override
  String get guildBulkBlockDirectMessages => 'Блокиране на директни съобщения';

  @override
  String get guildBulkAllowBotDirectMessages =>
      'Разрешаване на директни съобщения от ботове';

  @override
  String get guildBulkBlockBotDirectMessages =>
      'Блокиране на директни съобщения от ботове';

  @override
  String get guildNavbarGroupDm => 'Групов чат';

  @override
  String get guildNavbarCreateChannel => 'Създаване на канал';

  @override
  String get guildNavbarChannelType => 'Тип на канала';

  @override
  String get guildNavbarTextChannel => 'Текстов канал';

  @override
  String get guildNavbarTextChannelDescription =>
      'Изпращайте съобщения, изображения, GIF файлове и емотикони';

  @override
  String get guildNavbarVoiceChannel => 'Гласов канал';

  @override
  String get guildNavbarVoiceChannelDescription =>
      'Прекарвайте време заедно с глас, видео и споделяне на екран';

  @override
  String get guildNavbarLinkChannel => 'Свързване на канал';

  @override
  String get guildNavbarLinkChannelDescription =>
      'Бърз достъп до външен уебсайт или ресурс';

  @override
  String get guildNavbarNameLabel => 'Име';

  @override
  String get guildNavbarNewChannelHint => 'нов-канал';

  @override
  String get guildNavbarUrlLabel => 'URL адрес';

  @override
  String get guildNavbarUrlHint => 'https://example.com';

  @override
  String get guildNavbarChannelTypeSelection => 'Избор на тип канал';

  @override
  String get guildNavbarPrivateChannel => 'Частен канал';

  @override
  String get guildNavbarPrivateChannelDescription =>
      'Само избрани членове и роли ще могат да виждат този канал.';

  @override
  String get guildNavbarAddMembersOrRoles => 'Добавяне на членове или роли';

  @override
  String get guildNavbarAddMembersOrRolesHint => 'Търсене на членове или роли';

  @override
  String get guildNavbarCreateCategory => 'Създаване на категория';

  @override
  String get guildNavbarNewCategoryHint => 'Нова категория';

  @override
  String guildNavbarInviteFriendsTo(String communityName) {
    return 'Покани приятели в $communityName';
  }

  @override
  String guildNavbarInviteRecipientsChannel(String channelName) {
    return 'Получателите ще бъдат пренасочени към #$channelName';
  }

  @override
  String get guildNavbarSearchFriends => 'Търсене на приятели';

  @override
  String get guildNavbarNoFriendsYet => 'Все още нямате приятели';

  @override
  String get guildNavbarNoResults => 'Няма резултати';

  @override
  String get guildNavbarInviteLinkPrompt =>
      'Или изпратете покана по линк на приятел:';

  @override
  String get guildNavbarInviteLink => 'Линк за покана';

  @override
  String get guildNavbarCopy => 'Копирай';

  @override
  String get guildNavbarCopied => 'Копирано!';

  @override
  String get guildNavbarInviteExpiresSevenDays =>
      'Вашата покана изтича след 7 дни.';

  @override
  String get guildNavbarInviteNeverExpires =>
      'Тази връзка за покана никога не изтича.';

  @override
  String guildNavbarInviteExpiresIn(String duration) {
    return 'Вашата покана изтича след $duration.';
  }

  @override
  String get guildNavbarEditInviteLink => 'Редактиране на връзка за покана';

  @override
  String get guildNavbarInviteLinkSettings => 'Настройки на връзката за покана';

  @override
  String get guildNavbarExpireAfter => 'Изтича след';

  @override
  String get guildNavbarMaxUses => 'Максимален брой пъти';

  @override
  String get guildNavbarGrantTemporaryMembership =>
      'Предоставяне на временен достъп';

  @override
  String get guildNavbarTemporaryMembershipDescription =>
      'Членовете ще бъдат премахвани, когато излязат офлайн, освен ако не им бъде присвоена роля';

  @override
  String get guildNavbarCreateNewLink => 'Създай нова връзка';

  @override
  String get guildNavbarSent => 'Изпратено';

  @override
  String get guildNavbarInvite => 'Покани';

  @override
  String get guildNavbarLeaveCommunityTitle => 'Напусни общността';

  @override
  String get guildNavbarLeaveCommunityDescription =>
      'Сигурни ли сте, че искате да напуснете тази общност? Вече няма да можете да виждате съобщения.';

  @override
  String get guildNavbarLeaveCommunityConfirm => 'Напусни общността';

  @override
  String get guildNavbarDeleteMyMessagesTitle =>
      'Да изтриете съобщенията си в тази общност?';

  @override
  String get guildNavbarDeleteMyMessagesDescription =>
      'Изтрийте завинаги всички съобщения, които сте изпратили тук, във всеки канал. Не може да бъде отменено.';

  @override
  String get guildNavbarDeleteMyMessagesConfirm => 'Изтрий моите съобщения';

  @override
  String get guildNavbarDeletedYourMessages => 'Изтрихте съобщенията си';

  @override
  String get guildNavbarCouldNotDeleteYourMessages =>
      'Съобщенията ви не можаха да бъдат изтрити';

  @override
  String get guildNavbarRemoveOverride => 'Премахване на отмяната';

  @override
  String guildNavbarMutedUntil(String formattedDate) {
    return 'Заглушен до $formattedDate';
  }

  @override
  String guildNavbarStaffOnlyAccessible(String productName) {
    return 'Достъпно само за служители на $productName';
  }

  @override
  String get guildNavbarInvitesPaused =>
      'Поканите временно са на пауза в тази общност';

  @override
  String get guildNavbarDurationNever => 'никога';

  @override
  String get guildNavbarDuration30Minutes => '30 минути';

  @override
  String get guildNavbarDuration1Hour => '1 час';

  @override
  String get guildNavbarDuration6Hours => '6 часа';

  @override
  String get guildNavbarDuration12Hours => '12 часа';

  @override
  String get guildNavbarDuration1Day => '1 ден';

  @override
  String get guildNavbarDuration7Days => '7 дни';

  @override
  String guildNavbarDurationSeconds(int count) {
    return '$count секунди';
  }

  @override
  String get guildNavbarNever => 'Никога';

  @override
  String get guildNavbarNoLimit => 'Без ограничение';

  @override
  String get guildNavbarOneUse => '1 използване';

  @override
  String guildNavbarUses(int count) {
    return '$count пъти';
  }

  @override
  String get guildMenuMarkAsRead => 'Маркирай като прочетено';

  @override
  String get guildMenuInviteMembers => 'Покани членове';

  @override
  String get guildMenuCommunitySettings => 'Настройки на общността';

  @override
  String get guildMenuEditCommunityProfile =>
      'Редактиране на профила на общността';

  @override
  String get guildMenuUnmuteCommunity => 'Вдигни заглушаването на общността';

  @override
  String get guildMenuMuteCommunity => 'Заглуши общността';

  @override
  String get guildMenuHideMutedChannels => 'Скриване на заглушени канали';

  @override
  String get guildMenuDebugCommunity => 'Относно общността';

  @override
  String get guildMenuCopyCommunityId => 'Копирай ID на общността';

  @override
  String guildMenuMutedUntil(String formattedTime) {
    return 'До $formattedTime';
  }

  @override
  String get guildMenuSettingsGeneral => 'Общи';

  @override
  String get guildMenuSettingsRoles => 'Роли и разрешения';

  @override
  String get guildMenuSettingsEmoji => 'Емотикони';

  @override
  String get guildMenuSettingsStickers => 'Стикери';

  @override
  String get guildMenuSettingsSafetyModeration => 'Безопасност и модерация';

  @override
  String get guildMenuSettingsActivityLog => 'Дневник на активността';

  @override
  String get guildMenuSettingsWebhooks => 'Уебкуки';

  @override
  String get guildMenuSettingsDiscovery => 'Разглеждане';

  @override
  String get guildMenuSettingsMembers => 'Членове';

  @override
  String get guildMenuSettingsInviteLinks => 'Покани';

  @override
  String get guildMenuSettingsBans => 'Забрани';

  @override
  String get guildMenuSettingsChannels => 'Канали';

  @override
  String get guildSettingsNoPermission =>
      'Нямате разрешение да видите този раздел от настройките.';

  @override
  String get guildSettingsOverviewIconTitle => 'Икона';

  @override
  String get guildSettingsOverviewBannerTitle => 'Банер';

  @override
  String get guildSettingsOverviewNameTitle => 'Име';

  @override
  String get guildSettingsOverviewNameHint => 'Моята страхотна общност';

  @override
  String get guildSettingsCreateRole => 'Създаване на роля';

  @override
  String get guildSettingsRolesListTitle => 'Роли';

  @override
  String get guildSettingsRolesNewRole => 'Нова роля';

  @override
  String get guildSettingsRolesDeleteRole => 'Изтриване на роля';

  @override
  String get guildSettingsRolesBackToRoles => 'Обратно към ролите';

  @override
  String get guildSettingsBackToSettings => 'Обратно към настройките';

  @override
  String guildSettingsRolesEditTitle(String name) {
    return 'Редактиране на „$name“';
  }

  @override
  String get guildSettingsRolesEditSubtitle =>
      'Настройване на роля и разрешения';

  @override
  String get guildSettingsRolesDisplaySection => 'Показване';

  @override
  String get guildSettingsRolesRoleName => 'Име на ролята';

  @override
  String get guildSettingsRolesRoleColor => 'Цвят на ролята';

  @override
  String get guildSettingsRolesRoleColorHelper =>
      'Въведете цвят (шестнадесетичен код, rgb(), hsl() или име) или използвайте палитрата.';

  @override
  String get guildSettingsRolesShowSeparately => 'Показвай тази роля отделно';

  @override
  String get guildSettingsRolesShowSeparatelyHelper =>
      'Показва членовете с тази роля в отделна секция в списъка с членове.';

  @override
  String get guildSettingsRolesAllowMentions =>
      'Разрешаване на споменавания за тази роля';

  @override
  String guildSettingsRolesAllowMentionsHelper(String permission) {
    return 'Членовете с разрешението „$permission“ винаги могат да споменават роли, независимо от тази настройка.';
  }

  @override
  String get guildSettingsRolesRoleIcon => 'Role icon';

  @override
  String get guildSettingsRolesRoleIconHelper =>
      'Upload an image or pick an emoji. Members get the icon of their highest role that has one.';

  @override
  String guildSettingsRolesRoleIconUploadHint(
    String formats,
    String minimumSize,
    String maxSize,
  ) {
    return '$formats. At least $minimumSize, up to $maxSize.';
  }

  @override
  String get guildSettingsRolesRoleIconUploadAccessibility =>
      'Upload role icon';

  @override
  String guildSettingsRolesRoleIconCurrentEmojiAccessibility(String emojiName) {
    return 'Current role icon, $emojiName';
  }

  @override
  String get guildSettingsRolesRoleIconCurrentImageAccessibility =>
      'Current role icon, uploaded image';

  @override
  String get guildSettingsRolesRoleIconChooseEmoji => 'Choose emoji';

  @override
  String get guildSettingsRolesRoleIconUploadImage => 'Upload image';

  @override
  String get guildSettingsRolesRoleIconRemove => 'Remove icon';

  @override
  String get guildSettingsRolesRoleIconAnimatedError =>
      'Animated icons are not supported. Use a static image.';

  @override
  String guildSettingsRolesRoleIconUnsupportedTypeError(String formats) {
    return 'This file type is not supported. Supported types are $formats.';
  }

  @override
  String get guildSettingsRolesRoleIconLoadError =>
      'This image could not be loaded. Try another one.';

  @override
  String get guildSettingsRolesRoleIconUsagePreviewMessage =>
      'This is how messages appear';

  @override
  String roleIconAccessibilityLabel(String roleName) {
    return 'Role icon, $roleName';
  }

  @override
  String get roleIconCropTitle => 'Crop role icon';

  @override
  String get roleIconCropSave => 'Save icon';

  @override
  String get roleIconCropSkip => 'Skip cropping';

  @override
  String get roleIconCropFailed => 'Failed to crop icon. Try again.';

  @override
  String roleIconCropDescription(int minimumWidth, int minimumHeight) {
    return 'Drag to reposition your role icon and use the scroll wheel or pinch to zoom. The recommended minimum size is $minimumWidth×$minimumHeight pixels.';
  }

  @override
  String get guildSettingsRolesClearPermissionsHelp =>
      'Използвайте този бутон, за да изчистите бързо всички разрешения.';

  @override
  String get guildSettingsRolesClearPermissions => 'Изчистване на разрешенията';

  @override
  String get guildSettingsRolesPermissionsSection => 'Разрешения';

  @override
  String get guildSettingsRolesSearchPermissions => 'Търсене на разрешения';

  @override
  String get guildSettingsRolesDenseLayout => 'Сбит изглед';

  @override
  String get guildSettingsRolesComfyLayout => 'Удобно оформление';

  @override
  String get guildSettingsRolesSingleColumn => 'Една колона';

  @override
  String get guildSettingsRolesTwoColumns => 'Две колони';

  @override
  String get guildSettingsRolesNoPermissionsFound => 'Няма намерени разрешения';

  @override
  String get guildSettingsRolesHoistOrder => 'Подредба на показване';

  @override
  String get guildSettingsRolesResetHoistOrder =>
      'Възстановяване по подразбиране';

  @override
  String get guildSettingsRolesHoistOrderHelp =>
      'Влачете ролите, за да промените реда им в списъка с членове.';

  @override
  String get guildSettingsRolesNoHoistedRoles =>
      'Няма издигнати роли. Активирайте \"Показване на тази роля отделно\" за дадена роля, за да я видите тук.';

  @override
  String guildSettingsRolesNeedManageRolesPermission(String permission) {
    return 'Нужно е да имате разрешението „$permission“, за да редактирате тези разрешения';
  }

  @override
  String get guildSettingsRolesCannotEditHigherRole =>
      'Не можеш да редактираш роля, която е на твоето или по-високо ниво';

  @override
  String get guildSettingsRolesCannotGrantPermission =>
      'Не можеш да дадеш разрешение, което нямаш';

  @override
  String get guildSettingsRolesCannotRemoveOwnPermission =>
      'Не можеш да премахнеш това разрешение, защото така ще го премахнеш и от себе си';

  @override
  String get guildSettingsRolesUpdatedSuccess =>
      'Ролите са актуализирани успешно';

  @override
  String get guildSettingsRolesCreatedSuccess => 'Ролята е създадена успешно';

  @override
  String get guildSettingsRolesDeletedSuccess => 'Ролята е изтрита успешно';

  @override
  String get guildSettingsRolesHoistResetSuccess =>
      'Редът на показване е нулиран до подразбиране';

  @override
  String get guildSettingsRolesNameRequiredTitle =>
      'Името на ролята е задължително';

  @override
  String get guildSettingsRolesNameRequiredBody =>
      'Дайте име на ролята, преди да запазите.';

  @override
  String get guildSettingsRolesCreateFailedTitle =>
      'Ролята не можа да бъде създадена';

  @override
  String get guildSettingsRolesUpdateFailedTitle =>
      'Неуспешно актуализиране на ролите';

  @override
  String get guildSettingsRolesDeleteFailedTitle =>
      'Ролята не можа да бъде изтрита';

  @override
  String guildSettingsRolesDeleteFailedBody(String name) {
    return '„$name“ не може да бъде изтрит. Опитайте отново.';
  }

  @override
  String get guildSettingsRolesResetHoistFailedTitle =>
      'Неуспешно нулиране на реда за показване';

  @override
  String get guildSettingsRolesTryAgainInAMoment =>
      'Опитайте отново след малко.';

  @override
  String guildSettingsRolesDeleteConfirm(String name) {
    return 'Сигурни ли сте, че искате да изтриете ролята $name? Всички членове с тази роля вече няма да я имат.';
  }

  @override
  String get permissionCategoryCommunityWide => 'За цялата общност';

  @override
  String get permissionCategoryMessagesMedia => 'Съобщения и медия';

  @override
  String get permissionCategoryModeration => 'Модерация';

  @override
  String get permissionCategoryChannelAccess => 'Достъп до канал';

  @override
  String get permissionCategoryChannelManagement => 'Управление на канали';

  @override
  String get permissionCategoryAudioVideo => 'Аудио и видео';

  @override
  String get permissionAdministrator => 'Администратор';

  @override
  String get permissionAdministratorDescription =>
      'Предоставя всички разрешения и заобикаля ограниченията на канала. Изключително чувствително.';

  @override
  String get permissionViewActivityLog => 'Преглед на дневника за активност';

  @override
  String get permissionViewActivityLogDescription =>
      'Преглед на дневника за активност на общността за промени и модераторски действия.';

  @override
  String get permissionManageCommunity => 'Управление на общността';

  @override
  String get permissionManageCommunityDescription =>
      'Редактиране на общи настройки като име, описание и икона.';

  @override
  String get permissionManageRoles => 'Управление на роли';

  @override
  String get permissionManageRolesDescription =>
      'Създаване, редактиране или изтриване на роли под вашата най-висока роля. Позволява също редактиране на отменяния на разрешения за канали.';

  @override
  String get permissionManageChannels => 'Управление на канали';

  @override
  String get permissionManageChannel => 'Управление на канала';

  @override
  String get permissionManageChannelDescription =>
      'Преименуване и редактиране на настройките на този канал.';

  @override
  String get permissionManagePermissions => 'Управление на разрешенията';

  @override
  String get permissionManagePermissionsDescription =>
      'Редактиране на отменяния за роли и членове в този канал.';

  @override
  String get permissionManageWebhooksChannelDescription =>
      'Създаване, редактиране или изтриване на уебкуки за този канал.';

  @override
  String get permissionViewChannelMembersChannelDescription =>
      'Вижте списъка с членове за този канал.';

  @override
  String get permissionCreateInviteLinksChannelDescription =>
      'Управлявайте връзките за покани за този канал.';

  @override
  String get permissionOverwriteDeny => 'Отказ';

  @override
  String get permissionOverwriteInherit => 'Неутрално (наследяване)';

  @override
  String get permissionOverwriteAllow => 'Разрешаване';

  @override
  String get permissionOverwriteSetAllHelp =>
      'Използвайте тези бутони, за да зададете бързо всички разрешения.';

  @override
  String get permissionManageChannelsDescription =>
      'Създаване, редактиране или изтриване на канали и категории.';

  @override
  String get permissionKickMembers => 'Изгонване на членове';

  @override
  String get permissionBanMembers => 'Забраняване на достъп на членове';

  @override
  String get permissionCreateInviteLinks => 'Създаване на връзки за покани';

  @override
  String get permissionChangeOwnNickname => 'Промяна на собствен псевдоним';

  @override
  String get permissionChangeOwnNicknameDescription =>
      'Актуализирайте собствения си прякор.';

  @override
  String get permissionManageNicknames => 'Управление на прякори';

  @override
  String get permissionManageNicknamesDescription =>
      'Промяна на прякорите на другите членове.';

  @override
  String get permissionCreateEmojiStickers => 'Създаване на емоджита и стикери';

  @override
  String get permissionCreateEmojiStickersDescription =>
      'Качвайте нови емоджита и стикери и управлявайте собствените си творения.';

  @override
  String get permissionManageEmojiStickers =>
      'Управление на емоджита и стикери';

  @override
  String get permissionManageEmojiStickersDescription =>
      'Редактиране или изтриване на емоджита и стикери, създадени от други членове.';

  @override
  String get permissionManageWebhooks => 'Управление на уебкуки';

  @override
  String get permissionManageWebhooksDescription =>
      'Създаване, редактиране или изтриване на уеб куки.';

  @override
  String get permissionSendMessages => 'Изпращане на съобщения';

  @override
  String get permissionSendTtsMessages => 'Изпращане на TTS съобщения';

  @override
  String get permissionSendTtsMessagesDescription =>
      'Изпращане на съобщения с преобразуване на текст в реч.';

  @override
  String get permissionManageMessages => 'Управление на съобщения';

  @override
  String get permissionManageMessagesDescription =>
      'Изтриване на съобщения от други членове. Закачането се контролира отделно.';

  @override
  String get permissionPinMessages => 'Закачане на съобщения';

  @override
  String get permissionEmbedLinks => 'Вграждане на връзки';

  @override
  String get permissionAttachFiles => 'Прикачване на файлове';

  @override
  String get permissionMentionEveryone => 'Използвайте @everyone/@here и @роля';

  @override
  String get permissionMentionEveryoneDescription =>
      'Споменете всички или всяка роля (дори ако ролята не е настроена да може да бъде споменавана).';

  @override
  String get permissionUseExternalEmoji => 'Използване на външни емоджита';

  @override
  String get permissionUseExternalEmojiDescription =>
      'Използвайте емоджита от други общности.';

  @override
  String get permissionUseExternalStickers => 'Използване на външни стикери';

  @override
  String get permissionAddReactions => 'Добавяне на реакции';

  @override
  String get permissionAddReactionsDescription =>
      'Добавяне на нови реакции към съобщения.';

  @override
  String get permissionBypassSlowmode => 'Заобикаляне на бавен режим';

  @override
  String get permissionBypassSlowmodeDescription =>
      'Игнориране на ограниченията за честота на съобщенията за канал.';

  @override
  String get permissionTimeOutMembers => 'Временно ограничаване на членове';

  @override
  String get permissionTimeOutMembersDescription =>
      'Попречи на членовете да изпращат съобщения, да реагират и да се присъединяват към гласови чатове за определен период.';

  @override
  String get permissionViewChannel => 'Преглед на канал';

  @override
  String get permissionViewChannelMembers => 'Преглед на членовете на канала';

  @override
  String get permissionViewChannelMembersDescription =>
      'Вижте списъка с членове за каналите в тази общност.';

  @override
  String get permissionConnect => 'Свързване';

  @override
  String get permissionSpeak => 'Говори';

  @override
  String get permissionStreamVideo => 'Предаване на видео';

  @override
  String get permissionUseVoiceActivity => 'Използване на гласова активност';

  @override
  String get permissionUseVoiceActivityDescription =>
      'Без това разрешение е необходимо да използвате функцията \"Натисни и говори\".';

  @override
  String get permissionPrioritySpeaker => 'Приоритетен говорител';

  @override
  String get permissionMuteMembers => 'Изключване на звука на членове';

  @override
  String get permissionDeafenMembers => 'Заглушаване на членове';

  @override
  String get permissionMoveMembers => 'Преместване на членове';

  @override
  String get permissionMoveMembersDescription =>
      'Плъзнете членове между канали, до които имат достъп.';

  @override
  String get permissionSetVoiceRegion => 'Задаване на гласов регион';

  @override
  String get permissionManageThreads => 'Управление на нишки';

  @override
  String get permissionManageThreadsDescription =>
      'Преименуване, архивиране, заключване и изтриване на нишки, задаване на бавен режим за тях и преглед на частни нишки.';

  @override
  String get permissionCreatePublicThreads => 'Създаване на публични нишки';

  @override
  String get permissionCreatePublicThreadsDescription =>
      'Започване на нишки, които се виждат от всички, които имат достъп до канала.';

  @override
  String get permissionCreatePrivateThreads => 'Създаване на частни нишки';

  @override
  String get permissionCreatePrivateThreadsDescription =>
      'Започване на нишки само с покана.';

  @override
  String get permissionSendMessagesInThreads =>
      'Изпращане на съобщения в нишки';

  @override
  String get permissionSendMessagesInThreadsDescription =>
      'Изпращане на съобщения в нишки и публикации във форуми.';

  @override
  String get threadErrorArchived => 'Тази нишка е архивирана.';

  @override
  String get threadErrorLocked =>
      'Тази нишка е заключена. Само модераторите могат да пишат в нея или да я отворят отново.';

  @override
  String get threadErrorAlreadyCreated => 'За това съобщение вече има нишка.';

  @override
  String get threadErrorMaxActiveThreads =>
      'Тази общност достигна ограничението си за активни нишки.';

  @override
  String get threadErrorMaxMembers =>
      'Тази нишка достигна ограничението си за членове.';

  @override
  String get threadErrorMaxPinnedPosts =>
      'В този форум може да бъде закачена само една публикация.';

  @override
  String get threadErrorMaxForumTags =>
      'Един форум може да има най-много 20 етикета.';

  @override
  String get threadErrorTagNamesUnique =>
      'Имената на етикетите трябва да са уникални.';

  @override
  String get threadErrorNoTagsForEveryone =>
      'Добави етикет, който всички могат да използват, преди да направиш етикетите задължителни.';

  @override
  String get threadErrorTagRequired =>
      'Избери поне един етикет за тази публикация.';

  @override
  String get threadErrorUnknownTag =>
      'Един от избраните етикети вече не съществува.';

  @override
  String get threadErrorInvalidNotificationSettings =>
      'Тези настройки за известия не са валидни за нишка.';

  @override
  String get threadErrorSearchIndexNotReady =>
      'Публикациите все още се индексират. Опитай отново след малко.';

  @override
  String get threadErrorInvalidChannelType =>
      'Това действие не е налично в този канал.';

  @override
  String get threadCreate => 'Създаване на нишка';

  @override
  String get threadName => 'Име на нишката';

  @override
  String get threadNameRequired => 'Дай име на нишката.';

  @override
  String get threadNewThreadPlaceholder => 'Нова нишка';

  @override
  String get threadPrivate => 'Частна нишка';

  @override
  String get threadPrivateDescription =>
      'Само поканените от теб хора и модераторите могат да виждат тази нишка.';

  @override
  String get threadStarterMessage => 'Съобщение';

  @override
  String get threadStarterMessagePlaceholder =>
      'Въведи съобщение, за да започнеш разговора!';

  @override
  String threadCreateCooldown(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Можеш да започнеш нова нишка след $seconds секунди.',
      one: 'Можеш да започнеш нова нишка след 1 секунда.',
    );
    return '$_temp0';
  }

  @override
  String threadCreateFailed(String detail) {
    return 'Нишката не можа да бъде започната: $detail';
  }

  @override
  String get threadBrowserTitle => 'Нишки';

  @override
  String get threadBrowserActive => 'Активни';

  @override
  String get threadBrowserArchived => 'Затворени';

  @override
  String get threadBrowserJoined => 'Присъединени';

  @override
  String get threadBrowserOtherActive => 'Други активни нишки';

  @override
  String get threadBrowserPublic => 'Публични нишки';

  @override
  String get threadBrowserPrivate => 'Частни нишки';

  @override
  String get threadBrowserEmpty =>
      'Няма нишки. Съсредоточи се върху един разговор с нишка – временен текстов канал.';

  @override
  String get threadBrowserArchivedEmpty => 'Няма затворени нишки.';

  @override
  String get threadBrowserLoadMore => 'Зареди още';

  @override
  String get threadBrowserSearch => 'Търсене в нишките';

  @override
  String get threadBrowserSearchEmpty => 'Няма намерени нишки';

  @override
  String get threadBrowserSearchEmptyHint =>
      'Опитай друго име или провери другия раздел.';

  @override
  String get threadBrowserSearchFailed =>
      'Търсенето в нишките не успя. Опитай отново по-късно.';

  @override
  String get threadBrowserSearchIndexing =>
      'Търсенето в тази общност се подготвя. Скоро ще опитаме отново...';

  @override
  String threadMessageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count съобщения',
      one: '1 съобщение',
    );
    return '$_temp0';
  }

  @override
  String get threadFailedToMentionSomeRoles =>
      'Някои от споменатите роли не бяха добавени в тази нишка.';

  @override
  String get threadMembers => 'Членове на нишката';

  @override
  String threadMembersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count членове',
      one: '1 член',
    );
    return '$_temp0';
  }

  @override
  String get threadMembersEmpty =>
      'Все още никой не се е присъединил към тази нишка.';

  @override
  String threadRemoveMember(String name) {
    return 'Премахване на $name от нишката';
  }

  @override
  String get threadJoin => 'Присъединяване към нишката';

  @override
  String get threadLeave => 'Напускане на нишката';

  @override
  String get threadJoinNotice =>
      'Присъедини се към тази нишка, за да я следиш в списъка си с канали и да получаваш известия.';

  @override
  String get threadArchivedNotice =>
      'Тази нишка е затворена. Изпращането на съобщение ще я отвори отново.';

  @override
  String get threadLockedNotice =>
      'Тази нишка е заключена. Само модераторите могат да изпращат съобщения.';

  @override
  String get threadArchive => 'Затваряне на нишката';

  @override
  String get threadUnarchive => 'Повторно отваряне на нишката';

  @override
  String get threadLock => 'Заключване на нишката';

  @override
  String get threadUnlock => 'Отключване на нишката';

  @override
  String get threadDelete => 'Изтриване на нишката';

  @override
  String threadDeleteConfirm(String threadName) {
    return 'Сигурни ли сте, че искате да изтриете $threadName? Това не може да бъде отменено.';
  }

  @override
  String get threadDeleted => 'Нишката е изтрита';

  @override
  String get threadMarkAsRead => 'Маркирай като прочетено';

  @override
  String get threadMute => 'Изключване на известията за нишката';

  @override
  String get threadUnmute => 'Включване на известията за нишката';

  @override
  String get threadMuted => 'Известията за нишката са изключени';

  @override
  String get threadUnmuted => 'Известията за нишката са включени';

  @override
  String get threadNotificationSettings => 'Настройки за известия';

  @override
  String get threadNotificationParentDefault => 'Както е зададено за канала';

  @override
  String get threadCopyLink => 'Копирай линка';

  @override
  String get threadCopyId => 'Копирай ID на нишката';

  @override
  String get threadMoreOptions => 'Още опции';

  @override
  String get threadSettings => 'Настройки на нишката';

  @override
  String get threadSettingsSaved => 'Настройките на нишката са запазени';

  @override
  String get threadAutoArchive => 'Скриване след неактивност';

  @override
  String get threadAutoArchiveDescription =>
      'Нишката спира да се показва в списъка с канали след този период без активност.';

  @override
  String get threadDefaultAutoArchive =>
      'Скриване след неактивност по подразбиране';

  @override
  String get threadDefaultAutoArchiveDescription =>
      'Новите нишки спират да се показват в списъка с канали след този период без активност.';

  @override
  String get threadDefaultSlowmode => 'Бавен режим за нишки по подразбиране';

  @override
  String get threadAutoArchiveOneHour => '1 час';

  @override
  String get threadAutoArchiveOneDay => '24 часа';

  @override
  String get threadAutoArchiveThreeDays => '3 дни';

  @override
  String get threadAutoArchiveOneWeek => '1 седмица';

  @override
  String get threadInvitable => 'Всеки може да кани';

  @override
  String get threadInvitableDescription =>
      'Членовете на тази частна нишка могат да добавят други хора.';

  @override
  String threadStartedBy(String name) {
    return 'Започната от $name';
  }

  @override
  String get threadStarterDeleted => 'Оригиналното съобщение е изтрито.';

  @override
  String systemThreadCreated(
    String username,
    String threadLink,
    String allThreadsLink,
  ) {
    return '$username започна нишка: $threadLink. Виж $allThreadsLink.';
  }

  @override
  String get systemThreadCreatedAllThreadsLink => 'всички нишки';

  @override
  String get systemThreadCreatedThreadFallback => 'нишка';

  @override
  String systemPreviewThreadCreated(String username) {
    return '$username започна нишка.';
  }

  @override
  String get guildSettingsEmojiEmpty =>
      'Все още няма персонализирани емотикони.';

  @override
  String get guildSettingsStickersEmpty =>
      'Все още няма персонализирани стикери.';

  @override
  String get guildSettingsModerationVerificationTitle =>
      'Потвърждение на членството';

  @override
  String get guildSettingsModerationVerificationDescription =>
      'Изберете какво трябва да имат членовете, преди да могат да публикуват или да изпращат директни съобщения до членовете на общността.';

  @override
  String get guildSettingsModerationVerificationRolesBypass =>
      'Членовете с роли могат да заобиколят тези проверки. За публични пространства препоръчваме да активирате потвърждението.';

  @override
  String get guildSettingsModerationVerificationDiscoveryNote =>
      'Общностите, включени в „Разглеждане“, трябва да изискват поне потвърждение на имейл. Не можеш да избереш „Няма“, докато общността ти е включена в „Разглеждане“.';

  @override
  String get guildSettingsModerationMatureTitle =>
      'Съдържание за възрастни и предупреждения за съдържание';

  @override
  String get guildSettingsModerationMatureSectionDescription =>
      'Конфигурирайте етикетирането на неподходящо съдържание и незадължителни предупреждения за съдържание за членовете.';

  @override
  String get guildSettingsModerationMatureToggle => 'Съдържание за възрастни';

  @override
  String get guildSettingsModerationMatureToggleDescription =>
      'Маркирайте тази общност като съдържаща неподходящо съдържание.';

  @override
  String get guildSettingsVerificationNone => 'Няма';

  @override
  String get guildSettingsVerificationNoneDescription =>
      'Не се изисква потвърждение.';

  @override
  String get guildSettingsVerificationLow => 'Ниско';

  @override
  String get guildSettingsVerificationLowDescription =>
      'Изисква потвърден имейл адрес.';

  @override
  String get guildSettingsVerificationMedium => 'Средно';

  @override
  String get guildSettingsVerificationMediumDescription =>
      'Изисква потвърден имейл адрес и акаунт, създаден преди поне 5 минути.';

  @override
  String get guildSettingsVerificationHigh => 'Висока';

  @override
  String get guildSettingsVerificationHighDescription =>
      'Изисква всичко от средно ниво, плюс членство в общността от поне 10 минути.';

  @override
  String get guildSettingsAuditLogDescription =>
      'Проследяване на действията на модераторите в общността.';

  @override
  String get guildSettingsAuditLogEmpty => 'Все още няма записи';

  @override
  String get guildSettingsAuditLogEmptyDescription =>
      'Тук ще се показват действията за модериране и промените в общността.';

  @override
  String get guildSettingsAuditLogFilterAllUsers => 'Всички потребители';

  @override
  String get guildSettingsAuditLogFilterAllActions => 'Всички действия';

  @override
  String get guildSettingsAuditLogNoReason => 'Не е посочена причина.';

  @override
  String get guildSettingsAuditLogUnknownUser => 'Неизвестен потребител';

  @override
  String get guildSettingsAuditLogReason => 'Причина';

  @override
  String get guildSettingsAuditLogSomeone => 'някой';

  @override
  String get guildSettingsAuditLogSomething => 'нещо';

  @override
  String get guildSettingsAuditLogUnknownEntity => 'неизвестно лице';

  @override
  String get guildSettingsAuditLogNothing => 'нищо';

  @override
  String get guildSettingsAuditLogUnknownTarget => 'Неизвестна цел';

  @override
  String get auditLogActionGuildUpdate => 'Общността е актуализирана';

  @override
  String get auditLogActionChannelCreate => 'Каналът е създаден';

  @override
  String get auditLogActionChannelUpdate => 'Каналът е актуализиран';

  @override
  String get auditLogActionChannelDelete => 'Каналът е изтрит';

  @override
  String get auditLogActionThreadCreate => 'Нишката е създадена';

  @override
  String get auditLogActionThreadUpdate => 'Нишката е актуализирана';

  @override
  String get auditLogActionThreadDelete => 'Нишката е изтрита';

  @override
  String get auditLogActionChannelOverwriteCreate =>
      'Добавено е презаписване на канал';

  @override
  String get auditLogActionChannelOverwriteUpdate =>
      'Актуализирано разрешение за канал';

  @override
  String get auditLogActionChannelOverwriteDelete =>
      'Премахнато е презаписване на канал';

  @override
  String get auditLogActionMemberKick => 'Потребителят е изключен';

  @override
  String get auditLogActionMemberPrune => 'Членовете са премахнати';

  @override
  String get auditLogActionMemberBanAdd => 'Потребителят е блокиран';

  @override
  String get auditLogActionMemberBanRemove => 'Членът е деблокиран';

  @override
  String get auditLogActionMemberUpdate => 'Членът е актуализиран';

  @override
  String get auditLogActionMemberRoleUpdate => 'Актуализирани роли на членове';

  @override
  String get auditLogActionMemberMove => 'Членът е преместен';

  @override
  String get auditLogActionMemberDisconnect => 'Потребителят е изключен';

  @override
  String get auditLogActionBotAdd => 'Ботът е добавен';

  @override
  String get auditLogActionRoleCreate => 'Създадена роля';

  @override
  String get auditLogActionRoleUpdate => 'Ролята е актуализирана';

  @override
  String get auditLogActionRoleDelete => 'Ролята е изтрита';

  @override
  String get auditLogActionInviteCreate => 'Покана създадена';

  @override
  String get auditLogActionInviteUpdate => 'Поканата е актуализирана';

  @override
  String get auditLogActionInviteDelete => 'Поканата е изтрита';

  @override
  String get auditLogActionWebhookCreate => 'Уебхукът е създаден';

  @override
  String get auditLogActionWebhookUpdate => 'Уеб кука актуализирана';

  @override
  String get auditLogActionWebhookDelete => 'Уебхукът е изтрит';

  @override
  String get auditLogActionEmojiCreate => 'Създадено емоджи';

  @override
  String get auditLogActionEmojiUpdate => 'Емоджито е актуализирано';

  @override
  String get auditLogActionEmojiDelete => 'Изтрито емоджи';

  @override
  String get auditLogActionStickerCreate => 'Стикерът е създаден';

  @override
  String get auditLogActionStickerUpdate => 'Стикерът е актуализиран';

  @override
  String get auditLogActionStickerDelete => 'Стикерът е изтрит';

  @override
  String get auditLogActionMessageDelete => 'Съобщението е изтрито';

  @override
  String get auditLogActionMessageBulkDelete => 'Изтрити съобщения';

  @override
  String get auditLogActionMessagePin => 'Съобщението е закачено';

  @override
  String get auditLogActionMessageUnpin => 'Съобщението е открепено';

  @override
  String auditLogSummaryGuildUpdate(String actor) {
    return '$actor актуализира настройките на общността.';
  }

  @override
  String auditLogSummaryChannelCreate(String actor, String target) {
    return '$actor създаде канала $target.';
  }

  @override
  String auditLogSummaryChannelUpdate(String actor, String target) {
    return '$actor актуализира канала $target.';
  }

  @override
  String auditLogSummaryChannelDelete(String actor, String target) {
    return '$actor изтри канала $target.';
  }

  @override
  String auditLogSummaryThreadCreate(String actor, String target) {
    return '$actor започна нишката $target.';
  }

  @override
  String auditLogSummaryThreadUpdate(String actor, String target) {
    return '$actor актуализира нишката $target.';
  }

  @override
  String auditLogSummaryThreadDelete(String actor, String target) {
    return '$actor изтри нишката $target.';
  }

  @override
  String auditLogSummaryChannelOverwriteCreate(String actor, String target) {
    return '$actor добави разрешения за канала за $target.';
  }

  @override
  String auditLogSummaryChannelOverwriteCreateInChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor добави разрешения за канала за $target в $channel.';
  }

  @override
  String auditLogSummaryChannelOverwriteUpdate(String actor, String target) {
    return '$actor промени разрешенията за канала на $target.';
  }

  @override
  String auditLogSummaryChannelOverwriteUpdateInChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor промени разрешенията за канала за $target в $channel.';
  }

  @override
  String auditLogSummaryChannelOverwriteDelete(String actor, String target) {
    return '$actor премахна разрешенията за канала за $target.';
  }

  @override
  String auditLogSummaryChannelOverwriteDeleteInChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor премахна разрешенията за канала за $target в $channel.';
  }

  @override
  String auditLogSummaryMemberKick(String actor, String target) {
    return '$actor изгони $target.';
  }

  @override
  String auditLogSummaryMemberBanAdd(String actor, String target) {
    return '$actor забрани $target.';
  }

  @override
  String auditLogSummaryMemberBanRemove(String actor, String target) {
    return '$actor разблокира $target.';
  }

  @override
  String auditLogSummaryMemberUpdate(String actor, String target) {
    return '$actor актуализира $target.';
  }

  @override
  String auditLogSummaryMemberRoleUpdate(String actor, String target) {
    return '$actor промени ролите на $target.';
  }

  @override
  String auditLogSummaryMemberPrune(String actor) {
    return '$actor изтри неактивни членове.';
  }

  @override
  String auditLogSummaryMemberPruneDays(String actor, int days) {
    return '$actor премахна членове, неактивни от $days дни.';
  }

  @override
  String auditLogSummaryMemberMove(String actor, String target) {
    return '$actor премести $target в друг гласов канал.';
  }

  @override
  String auditLogSummaryMemberMoveToChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor премести $target в $channel.';
  }

  @override
  String auditLogSummaryMemberDisconnect(String actor, String target) {
    return '$actor прекъсна връзката на $target от гласов канал.';
  }

  @override
  String auditLogSummaryBotAdd(String actor, String target) {
    return '$actor добави бота $target.';
  }

  @override
  String auditLogSummaryRoleCreate(String actor, String target) {
    return '$actor създаде ролята $target.';
  }

  @override
  String auditLogSummaryRoleUpdate(String actor, String target) {
    return '$actor промени ролята на $target.';
  }

  @override
  String auditLogSummaryRoleDelete(String actor, String target) {
    return '$actor изтри ролята $target.';
  }

  @override
  String auditLogSummaryInviteCreate(String actor, String target) {
    return '$actor създаде поканата $target.';
  }

  @override
  String auditLogSummaryInviteCreateForChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor създаде поканата $target за $channel.';
  }

  @override
  String auditLogSummaryInviteUpdate(String actor, String target) {
    return '$actor актуализира поканата $target.';
  }

  @override
  String auditLogSummaryInviteUpdateForChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor актуализира поканата $target за $channel.';
  }

  @override
  String auditLogSummaryInviteDelete(String actor, String target) {
    return '$actor изтри поканата $target.';
  }

  @override
  String auditLogSummaryInviteDeleteForChannel(
    String actor,
    String target,
    String channel,
  ) {
    return '$actor изтри поканата $target за $channel.';
  }

  @override
  String auditLogSummaryWebhookCreate(String actor, String target) {
    return '$actor създаде webhook $target.';
  }

  @override
  String auditLogSummaryWebhookUpdate(String actor, String target) {
    return '$actor актуализира уебкука $target.';
  }

  @override
  String auditLogSummaryWebhookDelete(String actor, String target) {
    return '$actor изтри уебкука $target.';
  }

  @override
  String auditLogSummaryEmojiCreate(String actor, String target) {
    return '$actor добави емотикона $target.';
  }

  @override
  String auditLogSummaryEmojiUpdate(String actor, String target) {
    return '$actor актуализира емоджито $target.';
  }

  @override
  String auditLogSummaryEmojiDelete(String actor, String target) {
    return '$actor изтри емотикона $target.';
  }

  @override
  String auditLogSummaryStickerCreate(String actor, String target) {
    return '$actor добави стикера $target.';
  }

  @override
  String auditLogSummaryStickerUpdate(String actor, String target) {
    return '$actor актуализира стикера $target.';
  }

  @override
  String auditLogSummaryStickerDelete(String actor, String target) {
    return '$actor изтри стикера $target.';
  }

  @override
  String auditLogSummaryMessageDelete(String actor) {
    return '$actor изтри съобщение.';
  }

  @override
  String auditLogSummaryMessageDeleteInChannel(String actor, String channel) {
    return '$actor изтри съобщение в $channel.';
  }

  @override
  String auditLogSummaryMessageBulkDelete(String actor) {
    return '$actor изтри няколко съобщения.';
  }

  @override
  String auditLogSummaryMessageBulkDeleteCount(String actor, int count) {
    return '$actor изтри $count съобщения.';
  }

  @override
  String auditLogSummaryMessageBulkDeleteInChannel(
    String actor,
    String channel,
  ) {
    return '$actor изтри множество съобщения в $channel.';
  }

  @override
  String auditLogSummaryMessageBulkDeleteCountInChannel(
    String actor,
    int count,
    String channel,
  ) {
    return '$actor изтри $count съобщения в $channel.';
  }

  @override
  String auditLogSummaryMessagePin(String actor) {
    return '$actor прикачи съобщение.';
  }

  @override
  String auditLogSummaryMessagePinInChannel(String actor, String channel) {
    return '$actor прикачи съобщение в $channel.';
  }

  @override
  String auditLogSummaryMessageUnpin(String actor) {
    return '$actor премахна щифта от съобщение.';
  }

  @override
  String auditLogSummaryMessageUnpinInChannel(String actor, String channel) {
    return '$actor премахна закачане на съобщение в $channel.';
  }

  @override
  String auditLogSummaryDefault(String actor, String target) {
    return '$actor извърши одит на $target.';
  }

  @override
  String auditLogChangeUpdatedFromTo(
    String field,
    String oldValue,
    String newValue,
  ) {
    return 'Променихте $field от $oldValue на $newValue.';
  }

  @override
  String auditLogChangeSetTo(String field, String newValue) {
    return 'Задайте $field на $newValue.';
  }

  @override
  String auditLogChangeCleared(String field, String oldValue) {
    return 'Изчистено $field (беше $oldValue).';
  }

  @override
  String auditLogChangeUpdated(String field) {
    return 'Актуализирано $field.';
  }

  @override
  String auditLogChangeRenamedCommunity(String name) {
    return 'Преименувах общността на $name.';
  }

  @override
  String get auditLogChangeUpdatedCommunityIcon =>
      'Актуализира иконата на общността.';

  @override
  String get auditLogChangePausedInvites => 'Поканите бяха спрени временно.';

  @override
  String get auditLogChangeResumedInvites => 'Поканите бяха възобновени.';

  @override
  String get auditLogChangeTurnedOnDetachedBanner =>
      'Отделеният банер беше включен.';

  @override
  String get auditLogChangeTurnedOffDetachedBanner =>
      'Отделеният банер беше изключен.';

  @override
  String get auditLogChangeAllowedFlexibleChannelNames =>
      'Бяха разрешени гъвкави имена на текстови канали.';

  @override
  String get auditLogChangeDisallowedFlexibleChannelNames =>
      'Гъвкавите имена на текстови канали вече не са разрешени.';

  @override
  String get auditLogChangeHidOwnerCrown =>
      'Короната на собственика на общността беше скрита.';

  @override
  String get auditLogChangeShowedOwnerCrown =>
      'Короната на собственика на общността вече не е скрита.';

  @override
  String get auditLogChangeAllowedEmojiCloning =>
      'Беше разрешено други да клонират емоджитата на тази общност.';

  @override
  String get auditLogChangeStoppedEmojiCloning =>
      'Клонирането на емоджитата на тази общност от други вече не е разрешено.';

  @override
  String get auditLogChangeAllowedStickerCloning =>
      'Беше разрешено други да клонират стикерите на тази общност.';

  @override
  String get auditLogChangeStoppedStickerCloning =>
      'Клонирането на стикерите на тази общност от други вече не е разрешено.';

  @override
  String auditLogChangeRenamedChannel(String name) {
    return 'Преименувах канала на $name.';
  }

  @override
  String get auditLogChangeClearedTopic => 'Изчисти темата.';

  @override
  String auditLogChangeUpdatedTopic(String topic) {
    return 'Промених темата на $topic.';
  }

  @override
  String get auditLogChangeEnabledMatureContent =>
      'Разрешено е съдържание за възрастни.';

  @override
  String get auditLogChangeDisabledMatureContent =>
      'Деактивирано съдържание за възрастни.';

  @override
  String auditLogChangeSetNickname(String nickname) {
    return 'Задайте прякор на $nickname.';
  }

  @override
  String auditLogChangeRemovedNickname(String nickname) {
    return 'Премахнат прякор $nickname.';
  }

  @override
  String get auditLogChangeMutedMember => 'Заглуших члена.';

  @override
  String get auditLogChangeUnmutedMember => 'Членът беше размютен.';

  @override
  String get auditLogChangeDeafenedMember => 'Заглуших члена.';

  @override
  String get auditLogChangeUndeafenedMember =>
      'Премахнах заглушаването на члена.';

  @override
  String auditLogChangeAddedRoles(String roles) {
    return 'Добавени $roles.';
  }

  @override
  String auditLogChangeRemovedRoles(String roles) {
    return 'Премахнати $roles.';
  }

  @override
  String auditLogChangeRoleEmojiSet(String emoji) {
    return 'Set the role icon to $emoji';
  }

  @override
  String auditLogChangeRoleEmojiChanged(String oldEmoji, String newEmoji) {
    return 'Changed the role icon from $oldEmoji to $newEmoji';
  }

  @override
  String get auditLogChangeRoleEmojiRemoved => 'Removed the role icon';

  @override
  String get auditLogChangeRoleIconSet => 'Set a custom role icon';

  @override
  String get auditLogChangeRoleIconChanged => 'Changed the custom role icon';

  @override
  String get auditLogChangeRoleIconRemoved => 'Removed the custom role icon';

  @override
  String auditLogOptionChannel(String value) {
    return 'Канал: $value.';
  }

  @override
  String auditLogOptionMessage(String value) {
    return 'Съобщение: $value.';
  }

  @override
  String auditLogOptionInvitedBy(String value) {
    return 'Поканен от $value.';
  }

  @override
  String auditLogOptionDeletedMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Изтрити $count съобщения.',
      one: 'Изтрито $count съобщение.',
    );
    return '$_temp0';
  }

  @override
  String auditLogOptionRemovedMembers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Премахнати $count членове.',
      one: 'Премахнат $count член.',
    );
    return '$_temp0';
  }

  @override
  String get auditLogOptionInviteNeverExpires =>
      'Тази покана никога не изтича.';

  @override
  String get auditLogOptionTemporaryMembership => 'Предоставя временен достъп.';

  @override
  String get auditLogOptionPermanentMembership =>
      'Предоставя постоянно членство.';

  @override
  String get guildSettingsWebhooksDescription =>
      'Преглеждайте и управлявайте всички уебкуки, конфигурирани във вашата общност.';

  @override
  String get guildSettingsWebhooksEmpty => 'Няма уебкуки';

  @override
  String guildSettingsWebhooksEmptyDescription(String channelSettingsPath) {
    return 'Тази общност все още няма уебкуки. Отидете на $channelSettingsPath, за да създадете такава.';
  }

  @override
  String guildSettingsWebhooksPermissionRequired(String permission) {
    return 'За да преглеждате и редактирате уебкуки за тази общност, се нуждаете от разрешението „$permission“.';
  }

  @override
  String get guildSettingsWebhooksLoadFailedTitle =>
      'Неуспешно зареждане на уебкуки';

  @override
  String get guildSettingsWebhooksLoadFailedDescription =>
      'Възникна грешка при зареждането на уебкуките. Опитайте отново.';

  @override
  String get guildSettingsWebhooksUpdated => 'Уебкуките са актуализирани';

  @override
  String get guildSettingsWebhooksUpdateFailed =>
      'Неуспешно актуализиране на уебкуки';

  @override
  String get guildSettingsUnknownChannel => 'Неизвестен канал';

  @override
  String get guildSettingsCopiedUrl => 'URL адресът е копиран в клипборда';

  @override
  String get guildSettingsDiscoveryDescription =>
      'Включи общността си в „Разглеждане“, за да могат другите да я намират и да се присъединяват към нея.';

  @override
  String get guildSettingsDiscoveryNotEnoughMembersTitle =>
      'Няма достатъчно членове';

  @override
  String guildSettingsDiscoveryNotEligible(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count членове',
      one: '$count член',
    );
    return 'Общността ти трябва да има поне $_temp0, преди да може да бъде включена в „Разглеждане“.';
  }

  @override
  String get guildSettingsDiscoveryStatusLabel => 'Състояние:';

  @override
  String get guildSettingsDiscoveryStatusPending => 'Чакащи';

  @override
  String get guildSettingsDiscoveryStatusApproved => 'Одобрено';

  @override
  String get guildSettingsDiscoveryStatusRejected => 'Отхвърлено';

  @override
  String get guildSettingsDiscoveryStatusRemoved => 'Премахнато';

  @override
  String guildSettingsDiscoveryReason(String reason) {
    return 'Причина: $reason';
  }

  @override
  String get guildSettingsDiscoveryApprovedInfo =>
      'Общността ти е включена в „Разглеждане“. Можеш да актуализираш данните на обявата си по-долу или да я оттеглиш, за да я премахнеш.';

  @override
  String get guildSettingsDiscoveryPendingInfo =>
      'Заявлението ви е в процес на преглед. Все още можете да актуализирате данните за обявата си или да оттеглите заявлението.';

  @override
  String get guildSettingsDiscoveryCategory => 'Категория';

  @override
  String get guildSettingsDiscoveryCategoryHelp =>
      'Изберете категорията, която най-добре описва общността ви. Можете да я промените по всяко време.';

  @override
  String get guildSettingsDiscoveryPrimaryLanguage => 'Основен език';

  @override
  String get guildSettingsDiscoveryPrimaryLanguageHelp =>
      'Езикът, който общността ти говори най-често. Използва се за филтриране на резултатите в „Разглеждане“.';

  @override
  String get guildSettingsDiscoveryDescriptionField => 'Описание';

  @override
  String get guildSettingsDiscoveryDescriptionPlaceholder =>
      'Опишете за какво е вашата общност';

  @override
  String get guildSettingsDiscoveryDescriptionRequired =>
      'Изисква се описание.';

  @override
  String guildSettingsDiscoveryDescriptionMinLength(int minLength) {
    return 'Описанието трябва да е поне $minLength знака.';
  }

  @override
  String guildSettingsDiscoveryDescriptionMaxLength(int maxLength) {
    return 'Описанието трябва да е до $maxLength знака.';
  }

  @override
  String get guildSettingsDiscoveryTags => 'Персонализирани тагове';

  @override
  String guildSettingsDiscoveryTagsHelp(int maxTags) {
    return 'До $maxTags етикета помагат на хората да открият общността ти. Те се показват, когато хората търсят в „Разглеждане“.';
  }

  @override
  String get guildSettingsDiscoveryTagsHint =>
      'Добавете маркер и натиснете Enter';

  @override
  String get guildSettingsDiscoveryAddTag => 'Добавяне';

  @override
  String guildSettingsDiscoveryRemoveTag(String tag) {
    return 'Премахване на етикет $tag';
  }

  @override
  String get guildSettingsDiscoveryTagErrorTitle =>
      'Тагът не можа да бъде добавен';

  @override
  String guildSettingsDiscoveryTagRequirements(int maxLength) {
    return 'Таговете трябва да са от 2 до $maxLength знака и да съдържат букви и цифри.';
  }

  @override
  String guildSettingsDiscoveryTagLimit(int maxTags) {
    return 'Можете да добавяте до $maxTags тага.';
  }

  @override
  String get guildSettingsDiscoveryApply => 'Приложи';

  @override
  String get guildSettingsDiscoverySave => 'Запазване';

  @override
  String get guildSettingsDiscoveryWithdraw => 'Изтегляне';

  @override
  String get guildSettingsDiscoveryApplicationSent =>
      'Заявлението за „Разглеждане“ е изпратено';

  @override
  String get guildSettingsDiscoveryListingUpdated =>
      'Обявата в „Разглеждане“ е актуализирана';

  @override
  String get guildSettingsDiscoveryApplicationWithdrawn =>
      'Заявлението за „Разглеждане“ е оттеглено';

  @override
  String get guildSettingsDiscoveryWithdrawErrorTitle =>
      'Неуспешно оттегляне на заявлението';

  @override
  String get guildSettingsDiscoveryWithdrawErrorDescription =>
      'Опитайте отново след малко.';

  @override
  String get guildSettingsMembersSearchHint =>
      'Търсене по потребителско име или ID';

  @override
  String guildSettingsMembersResultsTitle(int count) {
    return '$count членове';
  }

  @override
  String get guildMembersRecentTitle => 'Нови членове';

  @override
  String guildMembersShowingCount(int displayedCount, int totalCount) {
    return 'Показване на $displayedCount от общо $totalCount членове';
  }

  @override
  String get guildMembersSort => 'Сортиране';

  @override
  String get guildSettingsMembersSortNewest => 'Първо най-новите';

  @override
  String get guildMembersSortOldest => 'Първо най-старите';

  @override
  String get guildMembersColumnName => 'Име';

  @override
  String get guildMembersColumnMemberSince => 'Член от';

  @override
  String guildMembersColumnJoinedProduct(String productName) {
    return 'Присъедини се към $productName';
  }

  @override
  String get guildMembersColumnJoinMethod => 'Начин на присъединяване';

  @override
  String get guildMembersColumnRoles => 'Роли';

  @override
  String get guildMembersFilterMemberSince => 'Филтриране по член от';

  @override
  String get guildMembersFilterJoinedProduct =>
      'Филтриране по дата на създаване на акаунт';

  @override
  String get guildMembersFilterJoinMethod =>
      'Филтриране по метод на присъединяване';

  @override
  String get guildMembersFilterRoles => 'Филтриране по роли';

  @override
  String get guildMembersFilterAll => 'Всички';

  @override
  String get guildMembersFilterPast1Hour => 'През последния час';

  @override
  String get guildMembersFilterPast24Hours => 'Последни 24 часа';

  @override
  String get guildMembersFilterPast7Days => 'Последните 7 дни';

  @override
  String get guildMembersFilterPast2Weeks => 'Последните 2 седмици';

  @override
  String get guildMembersFilterPast3Weeks => 'Последните 3 седмици';

  @override
  String get guildMembersFilterPast4Weeks => 'Последните 4 седмици';

  @override
  String get guildMembersFilterPast3Months => 'Последните 3 месеца';

  @override
  String get guildMembersFilterCustomRange => 'Персонализиран обхват...';

  @override
  String get guildMembersDateRangeTitle => 'Персонализиран период';

  @override
  String get guildMembersDateAfter => 'След дата';

  @override
  String get guildMembersDateBefore => 'Преди дата';

  @override
  String get guildMembersClearAll => 'Изчистване на всичко';

  @override
  String get guildMembersRowsPerPage => 'Редове на страница';

  @override
  String get guildMembersEmptySearch => 'Няма съвпадения с търсенето.';

  @override
  String get guildMembersLoadError =>
      'Възникна грешка при зареждане на членовете. Опитайте отново по-късно.';

  @override
  String get guildMembersIndexing => 'Индексиране на членове…';

  @override
  String get guildMembersJoinSourceCreator => 'Създател на общността';

  @override
  String get guildMembersJoinSourceInvite => 'Покани';

  @override
  String guildMembersJoinSourceInviteCode(String code) {
    return 'Покана ($code)';
  }

  @override
  String guildMembersJoinSourceInvitedBy(String name) {
    return 'Поканен от $name';
  }

  @override
  String get guildMembersJoinSourceVanityUrl => 'Персонализиран URL адрес';

  @override
  String get guildMembersJoinSourceBotInvite => 'Покана за бот';

  @override
  String get guildMembersJoinSourcePlatformAdmin => 'Админ на платформата';

  @override
  String get guildMembersJoinSourceDiscovery => 'Разглеждане';

  @override
  String get guildMembersJoinMethodUnknown => 'Неизвестен';

  @override
  String get guildMembersCommunityOwner => 'Собственик на общността';

  @override
  String get guildMembersViewAllRoles => 'Преглед на всички роли';

  @override
  String get guildMembersJoinedJustNow => 'Току-що';

  @override
  String guildMembersJoinedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count минути',
      one: 'преди 1 минута',
    );
    return '$_temp0';
  }

  @override
  String guildMembersJoinedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'преди $count часа',
      one: 'преди 1 час',
    );
    return '$_temp0';
  }

  @override
  String get guildMembersChannelListLabel => 'Членове';

  @override
  String get guildSettingsInvitesTitle => 'Покани';

  @override
  String get guildSettingsInvitesDescription =>
      'Преглед на всички покани за тази общност. За да създадете нова покана, отидете в канал и използвайте бутона за покана.';

  @override
  String get guildSettingsInvitesEmpty => 'Няма връзки за покани';

  @override
  String get guildSettingsInvitesEmptyDescription =>
      'Тази общност все още няма връзки за покани. Отидете в канал и създайте покана, за да поканите хора.';

  @override
  String get guildSettingsInvitesLoadFailedTitle =>
      'Неуспешно зареждане на покани';

  @override
  String get guildSettingsInvitesLoadFailedDescription =>
      'Възникна грешка при зареждането на поканите. Опитайте отново.';

  @override
  String get guildSettingsInvitesTryAgain => 'Опитай пак';

  @override
  String get guildSettingsInvitesShowCreatedDate =>
      'Показване на дата на създаване вместо дата на изтичане';

  @override
  String get guildSettingsInvitesPauseInvites => 'Спиране на поканите';

  @override
  String get guildSettingsInvitesEnableInvites => 'Разрешаване на покани';

  @override
  String get guildSettingsInvitesPauseForCommunityTitle =>
      'Спиране на поканите за тази общност';

  @override
  String get guildSettingsInvitesEnableForCommunityTitle =>
      'Разрешаване на покани за тази общност';

  @override
  String get guildSettingsInvitesPauseConfirmDescription =>
      'Да спрете поканите на пауза? Нови потребители няма да могат да се присъединяват чрез връзки за покани, докато не ги активирате отново. Това няма да засегне съществуващите членове.';

  @override
  String get guildSettingsInvitesEnableConfirmDescription =>
      'Да активирам ли поканите? Потребителите отново ще могат да се присъединяват към тази общност чрез връзки за покани.';

  @override
  String get guildSettingsInvitesPause => 'Пауза';

  @override
  String get guildSettingsInvitesPausedForCommunity =>
      'Поканите за тази общност са на пауза.';

  @override
  String guildSettingsInvitesPausedBecauseRaid(String productName) {
    return 'Поканите са на пауза, защото $productName откри потенциална атака. Нови потребители не могат да се присъединят в момента.';
  }

  @override
  String get guildSettingsInvitesLabelInviter => 'Поканил:';

  @override
  String get guildSettingsInvitesLabelChannel => 'Канал:';

  @override
  String get guildSettingsInvitesLabelCode => 'Код:';

  @override
  String get guildSettingsInvitesLabelUses => 'Използва:';

  @override
  String get guildSettingsInvitesLabelCreated => 'Създадено:';

  @override
  String get guildSettingsInvitesLabelExpires => 'Изтича:';

  @override
  String get guildSettingsInvitesUnknown => 'Неизвестен';

  @override
  String get guildSettingsInvitesNoCategory => 'Без категория';

  @override
  String get guildSettingsInvitesExpired => 'Изтекло';

  @override
  String get guildSettingsInvitesNever => 'Никога';

  @override
  String get guildSettingsInvitesCopyLink => 'Копирай линк за покана';

  @override
  String get guildSettingsInvitesRevoke => 'Отмени поканата';

  @override
  String get guildSettingsInvitesRevokeFailedTitle =>
      'Поканата не можа да бъде отменена';

  @override
  String get guildSettingsInvitesRevokeFailedDescription =>
      'Възможно е връзката все още да работи. Опитайте отново след малко.';

  @override
  String get guildSettingsBansDescription =>
      'Преглед и управление на блокирани потребители.';

  @override
  String get guildSettingsBansSearchHint => 'Търсене на забрани';

  @override
  String get guildSettingsBansEmpty => 'Няма забранени потребители.';

  @override
  String get guildSettingsBanExpiresLabel => 'Изтича на';

  @override
  String get guildSettingsBansNoSearchResults =>
      'Няма намерени забрани, отговарящи на търсенето ви.';

  @override
  String get guildSettingsBanDetailsTitle => 'Подробности за забраната';

  @override
  String get guildSettingsBanViewDetails => 'Преглед на детайли';

  @override
  String get guildSettingsBannedOn => 'Забранен на';

  @override
  String get guildSettingsBannedBy => 'Забранен от';

  @override
  String get guildSettingsRevokeBanTitle => 'Отмени забраната';

  @override
  String guildSettingsRevokeBanDescription(String displayName) {
    return 'Сигурни ли сте, че искате да отмените забраната за $displayName? Той/тя ще може да се присъедини отново към общността.';
  }

  @override
  String guildSettingsRevokeBanSuccess(String displayName) {
    return 'Премахнахме забраната за $displayName';
  }

  @override
  String get guildSettingsCommunitySettings => 'Настройки на общността';

  @override
  String get guildSettingsDeleteCommunity => 'Изтриване на общност';

  @override
  String get guildSettingsDeleteCommunityConfirm =>
      'Наистина ли искаш да изтриеш тази общност? Това действие не може да бъде отменено. Всички канали, съобщения и настройки ще бъдат изтрити завинаги.';

  @override
  String get guildSettingsCommunityDeleted => 'Общността е изтрита';

  @override
  String get guildSettingsDeleteCommunityFailed =>
      'Неуспешно изтриване на тази общност';

  @override
  String get guildSettingsCategoryExpressions => 'Изрази';

  @override
  String get guildSettingsCategoryCommunity => 'Общност';

  @override
  String get guildSettingsCategoryIntegrations => 'Интеграции';

  @override
  String get guildSettingsCategoryPeople => 'Хора';

  @override
  String get guildSettingsOverviewBrandingTitle => 'Брандиране';

  @override
  String get guildSettingsOverviewBrandingDescription =>
      'Актуализирайте иконата, името, банера и фоновото изображение за покани';

  @override
  String get guildSettingsOverviewBannerUpload => 'Качване на банер';

  @override
  String get guildSettingsOverviewIdleTitle => 'Настройки за неактивност';

  @override
  String get guildSettingsOverviewIdleDescription =>
      'Настройте AFK канал и време за изчакване';

  @override
  String get guildSettingsOverviewSystemTitle => 'Система и добре дошли';

  @override
  String get guildSettingsOverviewSystemDescription =>
      'Изберете дестинация за системни съобщения и съобщения за добре дошли';

  @override
  String get guildSettingsOverviewNotificationsTitle =>
      'Известия по подразбиране';

  @override
  String get guildSettingsOverviewNotificationsLargeGuild =>
      'Общности с над 250 души се прехвърлят към настройката \"само споменавания\". Първоначалната ви настройка се запазва и ще бъде възстановена, ако общността спадне под 250 членове.';

  @override
  String get guildSettingsOverviewFlexibleNames =>
      'Разрешаване на гъвкави имена на текстови канали';

  @override
  String get guildSettingsOverviewHideOwnerCrown =>
      'Скрий короната на собственика на общността';

  @override
  String get guildSettingsOverviewDetachedBanner => 'Разкачен банер';

  @override
  String get guildSettingsOverviewDetachedBannerHint =>
      'Показва банера в собствен раздел под заглавката на общността.';

  @override
  String get guildSettingsOverviewUploadIcon => 'Качване на икона';

  @override
  String get guildSettingsOverviewRemoveImage => 'Премахване';

  @override
  String get guildSettingsOverviewSplashTitle => 'Фон на поканата';

  @override
  String get guildSettingsOverviewEmbedSplashTitle => 'Фон на вграден чат';

  @override
  String get guildSettingsOverviewUploadBackground => 'Качване на фон';

  @override
  String get guildSettingsOverviewNoCommunityBanner =>
      'Няма банер на общността';

  @override
  String get guildSettingsOverviewNoInviteBackground => 'Без фон на покана';

  @override
  String get guildSettingsOverviewInvitePreviewTitle => 'Преглед';

  @override
  String get guildSettingsOverviewInvitePreviewHint =>
      'Вижте как изглежда поканата ви за посетителите.';

  @override
  String get guildSettingsOverviewTextChannelNamesTitle =>
      'Имена на текстови канали';

  @override
  String get guildSettingsOverviewOwnerCrownTitle =>
      'Корона на собственика на общността';

  @override
  String get guildSettingsOverviewOwnerCrownDescription =>
      'Настройте дали иконата на корона се показва до собственика на общността';

  @override
  String get guildSettingsSplashCardAlignment => 'Подравняване на картата';

  @override
  String get guildSettingsSplashAlignmentCenter => 'Центриране';

  @override
  String get guildSettingsSplashAlignmentLeft => 'Ляво';

  @override
  String get guildSettingsSplashAlignmentRight => 'Дясно';

  @override
  String get guildSettingsSplashAlignmentHint =>
      'Прилага се само на широки екрани.';

  @override
  String get permissionReadMessageHistory =>
      'Преглед на историята на съобщенията';

  @override
  String guildSettingsOverviewMessageHistoryTitle(String permission) {
    return 'Промени какво могат да виждат потребители без $permission';
  }

  @override
  String guildSettingsOverviewMessageHistoryDescription(String permission) {
    return 'Използвайте отделен прозорец, за да зададете дата за праг на историята на съобщенията за членове, които нямат разрешение $permission.';
  }

  @override
  String get guildSettingsOverviewMessageHistoryOpen =>
      'Праг за отваряне на историята на съобщенията';

  @override
  String get guildSettingsMessageHistoryThresholdTitle =>
      'Праг на историята на съобщенията';

  @override
  String get guildSettingsMessageHistoryThresholdEnable =>
      'Включване на праг за история на съобщенията';

  @override
  String get guildSettingsMessageHistoryThresholdDate => 'Дата на прага';

  @override
  String get guildSettingsMessageHistoryThresholdDateHint =>
      'Членове без история на прочетените съобщения могат да виждат съобщения, изпратени след тази дата.';

  @override
  String get guildSettingsMessageHistoryThresholdUpdated =>
      'Прагът за история на съобщенията е актуализиран';

  @override
  String get guildSettingsOverviewFlexibleNamesHint =>
      'Позволява главни букви и интервали в имената на текстовите канали. Изключването ограничава имената до малки букви с тирета и долни черти.';

  @override
  String get guildSettingsOverviewHideOwnerCrownHint =>
      'Скрива иконата с корона до собственика на общността на всички места.';

  @override
  String get guildSettingsAnimatedIconRequiresFeature =>
      'Анимираните икони изискват функцията за общността „Анимирани икони“.';

  @override
  String get guildSettingsAnimatedBannerRequiresFeature =>
      'Анимираните банери изискват функцията за анимирани банери на общността.';

  @override
  String get guildSettingsAfkChannel => 'Канал за неактивни потребители';

  @override
  String get guildSettingsAfkChannelHint =>
      'Премествай членовете в този канал, когато са неактивни.';

  @override
  String get guildSettingsNoAfkChannel => 'Няма AFK канал';

  @override
  String get guildSettingsAfkTimeout => 'Таймаут за неактивност';

  @override
  String get guildSettingsAfkTimeout1Min => '1 минута';

  @override
  String get guildSettingsAfkTimeout5Min => '5 минути';

  @override
  String get guildSettingsAfkTimeout15Min => '15 минути';

  @override
  String get guildSettingsAfkTimeout30Min => '30 минути';

  @override
  String get guildSettingsAfkTimeout1Hour => '1 час';

  @override
  String guildSettingsAfkTimeoutSeconds(int seconds) {
    return '$seconds секунди';
  }

  @override
  String get guildSettingsSystemChannel => 'Канал на местоназначението';

  @override
  String get guildSettingsSystemChannelHint =>
      'Добре дошли и системните съобщения ще се показват тук.';

  @override
  String get guildSettingsNoSystemChannel => 'Няма системен канал';

  @override
  String get guildSettingsHideJoinMessages =>
      'Скрий съобщенията за присъединяване';

  @override
  String get guildSettingsHideJoinMessagesHint =>
      'Скрива съобщенията за присъединяване в избрания канал.';

  @override
  String get guildSettingsDefaultNotifications =>
      'Настройки за известия по подразбиране';

  @override
  String get guildSettingsNotificationsAll => 'Всички съобщения';

  @override
  String get guildSettingsNotificationsAllDescription =>
      'Известия за всички съобщения';

  @override
  String get guildSettingsNotificationsMentions => 'Само споменавания';

  @override
  String get guildSettingsNotificationsMentionsDescription =>
      'Известия само при споменавания';

  @override
  String get guildSettingsOverviewSplashUploadHint =>
      'JPEG, PNG, WebP, AVIF. Максимум 10 MB. Минимум: 960×540px (16:9)';

  @override
  String get guildSettingsOverviewEmbedSplashUploadHint =>
      'JPEG, PNG, WebP, AVIF. Максимум 10 MB. Минимум: 960×540px (16:9). Показва се в покани в чата.';

  @override
  String get guildSettingsModerationContentFilterTitle =>
      'Филтриране на съдържание';

  @override
  String get guildSettingsModerationContentFilterDescription =>
      'Автоматично проверяване на съобщенията за изрично съдържание в канали, които не са маркирани за зряло съдържание.';

  @override
  String get guildSettingsModerationContentFilterDiscoveryNote =>
      'Общностите, включени в „Разглеждане“, трябва да сканират съобщенията от всички членове. Не можеш да промениш тази настройка, докато общността ти е включена в „Разглеждане“.';

  @override
  String get guildSettingsContentFilterOff => 'Изкл';

  @override
  String get guildSettingsContentFilterOffDescription =>
      'Нека общността се самомодерира';

  @override
  String get guildSettingsContentFilterNoRole =>
      'Филтриране на членове без роли';

  @override
  String get guildSettingsContentFilterNoRoleDescription =>
      'Препоръчително за повечето общности';

  @override
  String get guildSettingsContentFilterAll => 'Филтриране на всички';

  @override
  String get guildSettingsContentFilterAllDescription =>
      'Максимална защита за подходящи за семейството пространства';

  @override
  String get guildSettingsContentWarningToggle =>
      'Показване на предупреждение за съдържание';

  @override
  String get guildSettingsContentWarningToggleDescription =>
      'Превключва подкана за съгласие преди влизане във всеки канал.';

  @override
  String get guildSettingsContentWarningText =>
      'Персонализиран текст за предупреждение';

  @override
  String get guildSettingsContentWarningTextPlaceholder =>
      'Това съдържа чувствително съдържание.';

  @override
  String get guildSettingsModeration2faTitle =>
      'Изискване за двуфакторна автентикация';

  @override
  String get guildSettingsModeration2faDescription =>
      'Изискване на двуфакторно удостоверяване за модераторите, преди да могат да забраняват, изключват, временно ограничават или изтриват съобщения.';

  @override
  String get guildSettingsModeration2faSwitchLabel =>
      'Изискване на двуфакторна автентикация за модераторски действия';

  @override
  String get guildSettingsModeration2faEnableFirstTooltip =>
      'Активирайте двуфакторна автентикация в профила си, за да промените тази настройка';

  @override
  String get guildSettingsEmojiSearchHint => 'Търсене на емоджита';

  @override
  String get guildSettingsEmojiUploadTitle => 'Качване на емоджи';

  @override
  String get guildSettingsEmojiSlotsTitle => 'Слотове за емоджита';

  @override
  String get guildSettingsEmojiDropZone =>
      'Плъзнете и пуснете емоджи файлове тук';

  @override
  String get guildSettingsEmojiLoadFailed =>
      'Неуспешно зареждане на емоджита. Опитайте отново по-късно.';

  @override
  String get guildSettingsEmojiSearchEmpty =>
      'Няма намерени емоджита, отговарящи на търсенето ви.';

  @override
  String get guildSettingsEmojiSlotsFull =>
      'Достигнали сте максималния брой емоджита. Изтрийте някои съществуващи емоджита, за да освободите място.';

  @override
  String guildSettingsEmojiUploadRequirements(String maxSize) {
    return 'Имената на емотиконите трябва да съдържат поне 2 символа и могат да използват букви, цифри и долни черти. Емотиконите трябва да са под $maxSize. Статичните изображения се преоразмеряват до 128x128 пиксела и автоматично се компресират. Анимираните емотикони и SVG файловете вече трябва да отговарят на изискванията за размер.';
  }

  @override
  String get guildSettingsEmojiSomeFailedTitle =>
      'Някои емоджита не можаха да бъдат добавени';

  @override
  String get guildSettingsEmojiRenameTitle => 'Преименуване на емоджи';

  @override
  String get guildSettingsEmojiRenameHint =>
      '2-32 знака, букви, цифри, долни черти.';

  @override
  String get guildSettingsEmojiColumnName => 'Име';

  @override
  String get guildSettingsEmojiColumnUploader => 'Качено от';

  @override
  String get guildSettingsEmojiDeleteTitle => 'Изтриване на емоджи';

  @override
  String guildSettingsEmojiDeleteBody(String name) {
    return 'Изтрий :$name:? Това не може да бъде отменено.';
  }

  @override
  String get guildSettingsEmojiPurgeLabel =>
      'Изтриване на това емоджи от хранилището и CDN';

  @override
  String get guildSettingsEmojiNameTooShort =>
      'Името на емоджито трябва да е поне 2 знака';

  @override
  String get guildSettingsEmojiNameTooLong =>
      'Името на емоджито трябва да е най-много 32 знака';

  @override
  String get guildSettingsEmojiInvalidNameTitle => 'Невалидно име на емоджи';

  @override
  String get guildSettingsEmojiRenameFailedTitle =>
      'Неуспешно преименуване на това емоджи';

  @override
  String get guildSettingsEmojiDeleteFailedTitle =>
      'Изтриването на това емоджи е неуспешно';

  @override
  String get guildSettingsCloneEmojiTitle =>
      'Позволяване на други да клонират емоджитата ви';

  @override
  String get guildSettingsCloneEmojiDescription =>
      'Когато е активирано, членове на други общности могат да използват пряката \"Клониране\" с едно докосване в приложението за вашите персонализирани емотикони. Това не им пречи да запазят изображението и да го качат сами.';

  @override
  String get guildSettingsCloneStickerTitle =>
      'Позволяване на други да клонират стикерите ви';

  @override
  String get guildSettingsCloneStickerDescription =>
      'Когато е активирано, членове на други общности могат да използват пряката \"Клониране\" с едно докосване в приложението за вашите персонализирани стикери. Това не им пречи да запазват изображението и да го качват сами.';

  @override
  String guildSettingsClonePermissionHint(String permission) {
    return 'Само членове с разрешението „$permission“ могат да променят това.';
  }

  @override
  String get guildSettingsCloneEmojiUpdateFailed =>
      'Неуспешно актуализиране на клонирането на емоджита';

  @override
  String get guildSettingsCloneStickerUpdateFailed =>
      'Неуспешно актуализиране на клонирането на стикери';

  @override
  String guildSettingsNonAnimatedEmoji(int count) {
    return 'Неанимирани емотикони ($count)';
  }

  @override
  String guildSettingsAnimatedEmoji(int count) {
    return 'Анимирани емотикони ($count)';
  }

  @override
  String get guildSettingsStickersSearchHint => 'Търсене на стикери';

  @override
  String get guildSettingsStickerSlotsTitle => 'Слотове за стикери';

  @override
  String get guildSettingsStickerUploadTitle => 'Качване на стикер';

  @override
  String get guildSettingsStickerDropZone =>
      'Плъзнете и пуснете файл със стикер тук (един по един)';

  @override
  String get guildSettingsStickerDensity => 'Плътност на стикерите';

  @override
  String get guildSettingsStickerDensityCozy => 'Уютно';

  @override
  String get guildSettingsStickerDensityCompact => 'Компактен';

  @override
  String get guildSettingsStickersLoadFailedTitle =>
      'Неуспешно зареждане на стикери';

  @override
  String get guildSettingsStickersLoadFailedBody =>
      'Възникна грешка при зареждането на стикерите. Опитайте отново.';

  @override
  String get guildSettingsStickersSearchEmpty =>
      'Няма намерени стикери, отговарящи на търсенето ви.';

  @override
  String get guildSettingsStickerSlotsFull =>
      'Достигнали сте максималния брой стикери. Изтрийте някои съществуващи стикери, за да освободите място.';

  @override
  String guildSettingsStickerUploadRequirements(String maxSize) {
    return 'Стикерите се запазват в размер 320x320 пиксела и трябва да са под $maxSize. Статичните изображения се преоразмеряват и автоматично се компресират. Анимираните стикери и SVG файловете вече трябва да отговарят на изискванията за размер.';
  }

  @override
  String get guildSettingsStickerAddTitle => 'Добавяне на стикер';

  @override
  String get guildSettingsStickerEditTitle => 'Редактиране на стикер';

  @override
  String get guildSettingsStickerNameLabel => 'Име';

  @override
  String get guildSettingsStickerNameHint => 'Моят страхотен стикер';

  @override
  String get guildSettingsStickerDescriptionLabel => 'Описание';

  @override
  String get guildSettingsStickerDescriptionHint => 'Опишете стикера';

  @override
  String guildSettingsStickerTagsLabel(int count, int limit) {
    return 'Етикети ($count/$limit)';
  }

  @override
  String get guildSettingsStickerTagHint => 'Добавяне на етикет';

  @override
  String get guildSettingsStickerTagAdd => 'Добавяне';

  @override
  String get guildSettingsStickerNameRequired => 'Името е задължително';

  @override
  String get guildSettingsStickerNameTooShort =>
      'Името трябва да е поне 2 знака';

  @override
  String get guildSettingsStickerNameTooLong => 'Името трябва да е до 30 знака';

  @override
  String get guildSettingsStickerDescriptionTooLong =>
      'Описанието трябва да е до 500 знака';

  @override
  String get guildSettingsStickerCreateFailedTitle =>
      'Не може да се създаде този стикер';

  @override
  String get guildSettingsStickerDeleteTitle => 'Изтриване на стикер';

  @override
  String guildSettingsStickerDeleteBody(String name) {
    return 'Изтрий \"$name\"? Това действие не може да бъде отменено.';
  }

  @override
  String get guildSettingsStickerPurgeLabel =>
      'Изтриване на този стикер от хранилището и CDN';

  @override
  String get guildSettingsStickerDeleteFailedTitle =>
      'Не успях да изтрия този стикер';

  @override
  String guildSettingsWebhooksInfo(String channelSettingsPath) {
    return 'За да създадете уебкука, отворете $channelSettingsPath. Все още можете да редактирате и организирате всички съществуващи уебкуки тук.';
  }

  @override
  String get guildSettingsBannedUsersTitle => 'Блокирани потребители';

  @override
  String get guildSettingsInvitesTableInviter => 'Поканил';

  @override
  String get guildSettingsInvitesTableChannel => 'Канал';

  @override
  String get guildSettingsInvitesTableCode => 'Код';

  @override
  String get guildSettingsInvitesTableUses => 'Използва';

  @override
  String get guildSettingsInvitesTableCreated => 'Създадена';

  @override
  String get guildSettingsInvitesTableExpires => 'Изтича на';

  @override
  String get guildSettingsAuditLogFilterUser => 'Филтриране по потребител';

  @override
  String get guildSettingsAuditLogFilterAction => 'Филтриране по действие';

  @override
  String get createDm => 'Създаване на лично съобщение';

  @override
  String get createGroupDm => 'Създаване на групов чат';

  @override
  String get createDmNewMessage => 'Ново съобщение';

  @override
  String get createDmSelectFriends => 'Избери приятели';

  @override
  String get createDmChooseFriendsSubtitle =>
      'Изберете приятели, на които да изпратите съобщение.';

  @override
  String get createDmSearchFriends => 'Търсене на приятели';

  @override
  String get createDmNoFriendsFound => 'Няма намерени приятели';

  @override
  String get createDmNoFriendsYet => 'Все още нямате приятели';

  @override
  String get createDmClaimToStartDms =>
      'Заявете профила си, за да започнете директни съобщения.';

  @override
  String get createDmVerifyToStartDms =>
      'Потвърдете имейла си, за да започнете лични съобщения.';

  @override
  String get createDmVerifyYourEmail => 'Потвърдете имейла си';

  @override
  String get createDmNewGroup => 'Нова група';

  @override
  String createDmCreateGroupWithRecipient(String userName) {
    return 'Създаване на нова група с $userName';
  }

  @override
  String get createDmConfirmNewGroup => 'Потвърдете новата група';

  @override
  String get createDmCreateNewGroup => 'Създаване на нова група';

  @override
  String createDmRemoveFriend(String displayName) {
    return 'Премахване на $displayName';
  }

  @override
  String get createDmDuplicateGroupDescription =>
      'Вече имате група с тези потребители. Наистина ли искате да създадете нова? Няма проблем и така!';

  @override
  String get createDmNoActivityYet => 'Все още няма активност';

  @override
  String get createDmSomeUsersCantBeAdded =>
      'Някои потребители не могат да бъдат добавени';

  @override
  String get createDmCreateWithoutThem => 'Създаване без тях';

  @override
  String get createDmUnaddableIntro =>
      'Следните хора не могат да бъдат добавени към този групов чат:';

  @override
  String createDmUnaddableProceed(int count) {
    return 'Създаване на групов личен разговор с останалите $count получател(и) и пропускане на останалите?';
  }

  @override
  String get createDmUnaddableNoneRemaining =>
      'Няма останали получатели, с които да създадете групов чат.';

  @override
  String get createDmUnaddableUserNotFound => 'Потребителят не е намерен';

  @override
  String get createDmUnaddableBlocked =>
      'Не можеш да изпратиш съобщение на този потребител';

  @override
  String get createDmUnaddableNotFriends => 'Не е в списъка ви с приятели';

  @override
  String get createDmUnaddableGroupDisabled =>
      'Не позволява да бъде добавен към групови директни съобщения';

  @override
  String get dmListMessagesTitle => 'Съобщения';

  @override
  String get dmListDirectMessagesTitle => 'Лични съобщения';

  @override
  String get keybindsSearchShortcuts => 'Търсене на преки пътища';

  @override
  String get keybindSectionDefaults => 'По подразбиране';

  @override
  String get keybindSectionMessages => 'Съобщения';

  @override
  String get keybindSectionNavigation => 'Навигация';

  @override
  String get keybindSectionDragAndDrop => 'Влачене и пускане';

  @override
  String get keybindSectionChat => 'Чат';

  @override
  String get keybindSectionVoiceAndVideo => 'Гласови и видео';

  @override
  String get keybindSectionMisc => 'Разни';

  @override
  String get keybindActionShowShortcutsList =>
      'Показване на списъка с клавишни комбинации';

  @override
  String get keybindActionCopyText => 'Копиране на текст';

  @override
  String get keybindActionMarkUnread => 'Маркирай като непрочетено';

  @override
  String get keybindActionFocusTextarea => 'Фокусиране на текстовото поле';

  @override
  String get keybindActionSwitchCommunities => 'Превключване между общности';

  @override
  String get keybindActionSwitchChannels => 'Превключване между канали';

  @override
  String get keybindActionHistoryBack => 'Преглед на предишни канали';

  @override
  String get keybindActionHistoryForward =>
      'Напред в историята на прегледаните канали';

  @override
  String get keybindActionJumpUnreadChannels =>
      'Прескачане между непрочетени канали';

  @override
  String get keybindActionJumpMentionChannels =>
      'Прескачане между непрочетени канали със споменавания';

  @override
  String get keybindActionJumpCurrentCall => 'Към текущото обаждане';

  @override
  String get keybindActionToggleLastGuildDms =>
      'Превключване между последна общност и лични съобщения';

  @override
  String get keybindActionPreviousCommunityOrDms =>
      'Превключване към предишна общност или директни съобщения';

  @override
  String get keybindActionNextCommunityOrDms =>
      'Превключване към следваща общност или лични съобщения';

  @override
  String get keybindActionGoToDms => 'Отиди до лични съобщения';

  @override
  String get keybindActionGoToFirstCommunity => 'Към първата общност';

  @override
  String get keybindActionGoToSecondCommunity => 'Към втора общност';

  @override
  String get keybindActionGoToThirdCommunity => 'Към трета общност';

  @override
  String get keybindActionGoToFourthCommunity =>
      'Отиване към четвъртата общност';

  @override
  String get keybindActionGoToFifthCommunity => 'Отиване до петата общност';

  @override
  String get keybindActionGoToSixthCommunity => 'Отиване към шестата общност';

  @override
  String get keybindActionGoToSeventhCommunity => 'Отиване на седмата общност';

  @override
  String get keybindActionGoToEighthCommunity => 'Отиване до осмата общност';

  @override
  String get keybindActionToggleQuickSwitcher =>
      'Превключване на бърз превключвател';

  @override
  String get keybindActionCreateOrJoinCommunity =>
      'Създаване или присъединяване към общност';

  @override
  String get keybindActionStartDragAndDrop => 'Започване на плъзгане и пускане';

  @override
  String get keybindActionMove => 'Премести';

  @override
  String get keybindActionDropItem => 'Изхвърляне на предмет';

  @override
  String get keybindActionCancel => 'Отказ';

  @override
  String get keybindActionMarkCommunityRead =>
      'Отбелязване на общността като прочетена';

  @override
  String get keybindActionMarkChannelRead => 'Маркирай канала като прочетен';

  @override
  String get keybindActionStartGroupDm => 'Започване на групов чат';

  @override
  String get keybindActionTogglePinnedMessages =>
      'Превключване на закачените съобщения';

  @override
  String get keybindActionToggleInbox => 'Превключване на входящата кутия';

  @override
  String get keybindActionMarkTopInboxRead =>
      'Отбелязване на най-горния канал във входящата поща като прочетен';

  @override
  String get keybindActionMarkAllInboxRead =>
      'Отбелязване на всички канали във входящата поща като прочетени';

  @override
  String get keybindActionToggleMemberList =>
      'Превключване на списъка с членове или гласовия чат';

  @override
  String get keybindActionToggleEmojiPicker =>
      'Превключване на палитрата с емотикони';

  @override
  String get keybindActionToggleGifPicker => 'Превключване на GIF селектора';

  @override
  String get keybindActionToggleStickerPicker =>
      'Превключване на инструмента за избор на стикери';

  @override
  String get keybindActionScrollChatUp => 'Превъртане на чата нагоре';

  @override
  String get keybindActionScrollChatDown => 'Превъртане на чата надолу';

  @override
  String get keybindActionJumpOldestUnread =>
      'Към най-старото непрочетено съобщение';

  @override
  String get keybindActionFocusComposer => 'Фокусиране на текстовото поле';

  @override
  String get keybindActionUploadFile => 'Качване на файл';

  @override
  String get keybindActionCopyChannelLink => 'Копиране на връзка към канала';

  @override
  String get keybindActionToggleSavedMedia => 'Превключване на запазени медии';

  @override
  String get keybindActionSendVoiceMessage => 'Изпращане на гласово съобщение';

  @override
  String get keybindActionAnswerCall => 'Отговор на входящо повикване';

  @override
  String get keybindActionDeclineCall => 'Отхвърляне на входящото повикване';

  @override
  String get keybindActionStartDmCall =>
      'Започни разговор в лично съобщение или група';

  @override
  String get keybindActionToggleSoundboard => 'Превключване на звуковата дъска';

  @override
  String get keybindActionToggleCompactCallView =>
      'Разгъване или свиване на компактен изглед на разговор';

  @override
  String get keybindActionPushToTalkPriority =>
      'Натисни, за да говориш (приоритетно)';

  @override
  String get keybindActionVoiceActivityPriority =>
      'Приоритет на гласовата активност';

  @override
  String get keybindActionOpenHelp => 'Отваряне на помощ';

  @override
  String get keybindActionSearchMessages => 'Търсене в съобщенията';

  @override
  String get keybindActionOpenContextMenu => 'Отваряне на контекстното меню';

  @override
  String get keybindActionOpenSettings => 'Отвори настройките си';

  @override
  String get keybindActionOpenThemeStudio =>
      'Отваряне на изскачащ прозорец за студио за теми';

  @override
  String get keybindActionZoomIn => 'Увеличаване';

  @override
  String get keybindActionZoomOut => 'Намаляване';

  @override
  String get keybindActionZoomReset => 'Възстановяване на мащаба';

  @override
  String get clipboardPasteFailed =>
      'Не успях да поставя. Буферът за обмен е празен или блокиран за това приложение.';

  @override
  String get homeQuickActionDms => 'Лични съобщения';

  @override
  String get assistantNeedsLogin =>
      'Първо отворете Fluxer и влезте в профила си.';

  @override
  String get assistantNotInVoice => 'Не сте в разговор.';

  @override
  String get assistantNotFound => 'Fluxer не можа да намери това.';

  @override
  String get assistantDmsDisabled =>
      'Директните съобщения са деактивирани в този екземпляр.';

  @override
  String get assistantFailed => 'Fluxer не можа да изпълни това.';

  @override
  String get assistantOkMuted => 'Микрофонът е изключен.';

  @override
  String get assistantOkUnmuted => 'Микрофонът е включен.';

  @override
  String get assistantOkLeftVoice => 'Напуснахте гласовия канал.';

  @override
  String get assistantOkJoinedVoice => 'Присъединяване към гласовия канал.';

  @override
  String get assistantOkStartedCall => 'Започвам разговора.';

  @override
  String assistantOkStatusSet(String status) {
    return 'Статусът е зададен на $status.';
  }

  @override
  String get assistantOkOpened => 'Отварям Fluxer.';

  @override
  String get assistantOkMessageSent => 'Съобщението е изпратено.';

  @override
  String get assistantOkCustomStatusSet =>
      'Персонализираният статус е актуализиран.';

  @override
  String get assistantOkCustomStatusCleared =>
      'Персонализираният статус е изчистен.';

  @override
  String get guildNavbarAnnouncementChannel => 'Канал за обявления';

  @override
  String get guildNavbarAnnouncementChannelDescription =>
      'Публикувайте актуализации, които други общности могат да следват в собствените си канали';

  @override
  String get channelDetailsAnnouncementChannel => 'Канал за обявления';

  @override
  String get channelSettingsAnnouncementChannel => 'Канал за обявления';

  @override
  String get channelSettingsAnnouncementChannelDescription =>
      'Позволява на други общности да следват този канал и да получават копия на това, което публикувате.';

  @override
  String get channelSettingsStopAnnouncementTitle =>
      'Да спре ли да бъде канал за обявления?';

  @override
  String channelSettingsStopAnnouncementBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count канала следват този канал. Ако го преобразувате в текстов канал, тези следвания ще бъдат премахнати.',
      one:
          '1 канал следва този канал. Ако го преобразувате в текстов канал, това следване ще бъде премахнато.',
    );
    return '$_temp0';
  }

  @override
  String get channelSettingsStopAnnouncementUnknown =>
      'Ако преобразувате този канал в текстов канал, никой канал вече няма да го следва.';

  @override
  String get channelSettingsConvertChannel => 'Преобразуване';

  @override
  String get channelSettingsConvertFailed =>
      'Не успяхме да преобразуваме този канал';

  @override
  String get channelSettingsChannelHasFollowers =>
      'Други канали все още следват този канал. Премахнете тези следвания, преди да го преобразувате.';

  @override
  String get channelMenuFollow => 'Следвай канала';

  @override
  String get channelFollowTitle => 'Следвай този канал';

  @override
  String get channelFollowBody =>
      'Изберете къде да отиват публикуваните съобщения. Можете да прекратите проследяването по всяко време в Настройки на общността → Уебхукове.';

  @override
  String get channelFollowCommunity => 'Общност';

  @override
  String get channelFollowChannel => 'Канал';

  @override
  String get channelFollowAgeWarning =>
      'Това е канал с възрастово ограничение. Актуализациите могат да отиват само в канали с възрастово ограничение.';

  @override
  String get channelFollowContentWarning =>
      'Този канал има предупреждение за съдържание. Актуализациите могат да отиват само в канали с предупреждение за съдържание или възрастово ограничение.';

  @override
  String get channelFollowHiddenHint =>
      'Общностите и каналите, където не можете да управлявате уебхукове, са скрити.';

  @override
  String get channelFollowEmpty =>
      'Не можете да управлявате уебхукове в никоя общност. Помолете администратор да следва този канал.';

  @override
  String get channelFollowSubmit => 'Следвай';

  @override
  String get channelFollowFailed => 'Неуспешно следване на този канал.';

  @override
  String get channelFollowSuccessTitle => 'Актуализациите са на път!';

  @override
  String channelFollowSuccessBody(String sourceName, String targetName) {
    return 'Съобщенията, публикувани в $sourceName, ще се показват в #$targetName.';
  }

  @override
  String get channelFollowSuccessDismiss => 'Разбрано!';

  @override
  String get channelFollowBarrier =>
      'Следвайте този канал, за да получавате тези обявления в канал по ваш избор.';

  @override
  String get channelHeaderFollow => 'Следвай канала';

  @override
  String get chatMessagePublish => 'Публикувай';

  @override
  String get chatMessagePublished => 'Публикувано';

  @override
  String get chatMessagePublishConfirmTitle => 'Публикуване на съобщение?';

  @override
  String get chatMessagePublishConfirmBody =>
      'Това ще изпрати копие до всеки канал, който следва този.';

  @override
  String get chatMessagePublishedToast => 'Съобщението е публикувано';

  @override
  String get chatMessageAlreadyPublished =>
      'Това съобщение вече е публикувано.';

  @override
  String get chatMessagePublishFailedTitle =>
      'Неуспешно публикуване на това съобщение';

  @override
  String get chatMessagePublishFailedBody =>
      'Нещо се обърка. Опитайте отново след малко.';

  @override
  String get chatMessagePublishLimitTitle => 'По-бавно';

  @override
  String chatMessagePublishLimitBody(String duration) {
    return 'Можете да публикувате отново след $duration.';
  }

  @override
  String get chatMessagePublishLimitUnknown =>
      'Публикувате твърде бързо. Опитайте отново след малко.';

  @override
  String get chatMessageDeletePublished =>
      'Това също премахва копията, които са били изпратени до канали, следващи този.';

  @override
  String get chatMessageEditPublishedTitle =>
      'Редактиране на публикувано съобщение?';

  @override
  String get chatMessageEditPublishedBody =>
      'Това актуализира копията, които бяха изпратени до каналите, следващи този.';

  @override
  String get chatMessageEditPublishedSave => 'Запазване';

  @override
  String get chatMessageEditLimitTitle => 'По-бавно';

  @override
  String chatMessageEditLimitBody(String duration) {
    return 'Можете да редактирате това публикувано съобщение отново след $duration.';
  }

  @override
  String get chatMessageEditLimitUnknown =>
      'Редактирате това публикувано съобщение твърде бързо. Опитайте отново след малко.';

  @override
  String get chatMessageOriginalDeleted => '[Оригиналното съобщение е изтрито]';

  @override
  String get userTagCommunity => 'Общност';

  @override
  String systemFollowAdd(String username, String source) {
    return '$username настрои този канал да следва $source. Публикуваните там съобщения ще се показват тук.';
  }

  @override
  String systemPreviewFollowAdd(String username, String source) {
    return '$username настрои този канал да следва $source.';
  }

  @override
  String get publishNudgeNotSent => 'Все още не е изпратено до последователи.';

  @override
  String get publishNudgeHideForever => 'Не показвай повече';

  @override
  String get publishNudgeDismiss => 'Скрий';

  @override
  String get channelSettingsFollowedChannels => 'Следвани канали';

  @override
  String get channelSettingsFollowedChannelsDescription =>
      'Канали за обявления, които този канал следва. Прекратете следването, за да спрете да получавате копия.';

  @override
  String get guildSettingsFollowedChannelsDescription =>
      'Канали за обявления, следвани от канали в тази общност.';

  @override
  String channelSettingsFollowedFrom(String guildName, String channelName) {
    return 'От $guildName #$channelName';
  }

  @override
  String get channelSettingsFollowedPaused =>
      'Актуализациите са на пауза, защото изходният канал вече не е наличен.';

  @override
  String channelSettingsUnfollowTitle(String name) {
    return 'Да се прекрати ли следването на $name?';
  }

  @override
  String get channelSettingsUnfollowBody =>
      'Този канал ще спре да получава копия от онзи канал за обявления.';

  @override
  String get channelSettingsUnfollow => 'Прекрати следването';

  @override
  String get crosspostCommunityTitle => 'Общност';

  @override
  String get crosspostGoToCommunity => 'Към общността';

  @override
  String get crosspostJoinCommunity => 'Присъединяване към общността';

  @override
  String get crosspostSourceFailed =>
      'Не успяхме да заредим тази общност. Опитайте отново след малко.';

  @override
  String crosspostMembers(int count) {
    return '$count членове';
  }

  @override
  String crosspostOnline(int count) {
    return '$count онлайн';
  }

  @override
  String durationMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минути',
      one: '1 минута',
    );
    return '$_temp0';
  }

  @override
  String durationSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count секунди',
      one: '1 секунда',
    );
    return '$_temp0';
  }

  @override
  String get channelUnsupportedTitle => 'Неподдържан тип канал';

  @override
  String get channelUnsupportedBody =>
      'Тази версия на приложението не поддържа този тип канал.';

  @override
  String get channelDetailsUnsupportedChannel => 'Неподдържан канал';

  @override
  String get forumChannelTypeForum => 'Форум';

  @override
  String get forumChannelTypeForumDescription =>
      'Публикации, организирани по тема и етикети';

  @override
  String get forumChannelTypeMedia => 'Медия';

  @override
  String get forumChannelTypeMediaDescription =>
      'Публикации, изградени около изображения и видеоклипове';

  @override
  String get forumNewPost => 'Нова публикация';

  @override
  String get forumNewMediaPost => 'Нова медийна публикация';

  @override
  String get forumSearchPosts => 'Търсене в публикации';

  @override
  String get forumViewOptions => 'Сортиране и изглед';

  @override
  String get forumSearchIndexing =>
      'Търсенето все още се подготвя за тази общност. Публикациите ще се появят тук веднага щом е готово.';

  @override
  String get forumNoPosts => 'Все още няма публикации';

  @override
  String get forumNoPostsHint => 'Бъди първият, който ще започне разговор тук.';

  @override
  String get forumNoSearchResults =>
      'Няма публикации, отговарящи на търсенето ти';

  @override
  String get forumNoSearchResultsHint =>
      'Опитай други думи или изчисти филтъра по етикети.';

  @override
  String get forumCreateFirstPost => 'Създай първата публикация';

  @override
  String get forumOlderPosts => 'По-стари публикации';

  @override
  String get forumPostsLoadFailed =>
      'Публикациите не можаха да бъдат заредени.';

  @override
  String get forumRetry => 'Опитай отново';

  @override
  String get forumPostPinned => 'Закачено';

  @override
  String get forumPostLocked => 'Заключена';

  @override
  String get forumPostArchived => 'Архивирана';

  @override
  String get forumPostNewBadge => 'Нови';

  @override
  String get forumPostStarterDeleted => 'Първоначалното съобщение е изтрито.';

  @override
  String forumPostSnippet(String author, String content) {
    return '$author: $content';
  }

  @override
  String forumPostNewMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нови съобщения',
      one: '$count ново съобщение',
    );
    return '$_temp0';
  }

  @override
  String get forumPostReact => 'Добави реакцията по подразбиране';

  @override
  String get forumOpenPost => 'Отвори публикацията';

  @override
  String get forumEditTags => 'Редактиране на етикети';

  @override
  String get forumSaveTags => 'Запази етикетите';

  @override
  String forumTagsLimitHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Избери до $count етикета.',
      one: 'Избери до 1 етикет.',
    );
    return '$_temp0';
  }

  @override
  String get forumPinPost => 'Закачи публикацията';

  @override
  String get forumUnpinPost => 'Откачи публикацията';

  @override
  String get forumMarkPostRead => 'Маркирай като прочетено';

  @override
  String get forumCopyPostLink => 'Копирай линка';

  @override
  String get forumPostGuidelines => 'Насоки за публикуване';

  @override
  String get forumGuidelinesPlaceholder =>
      'Кажи на хората какво да публикуват тук и как да го правят.';

  @override
  String get forumPostTitle => 'Заглавие';

  @override
  String get forumPostMessage => 'Съобщение';

  @override
  String get forumPostMessagePlaceholder =>
      'Напиши първото съобщение на публикацията си';

  @override
  String get forumPostMediaPlaceholder => 'Добави надпис';

  @override
  String get forumPostTags => 'Етикети';

  @override
  String get forumPostTagsRequired => 'Етикети (задължително)';

  @override
  String get forumPostAddMedia => 'Добави медия';

  @override
  String get forumPostAddFile => 'Добави файл';

  @override
  String get forumPostRemoveAttachment => 'Премахване на прикачен файл';

  @override
  String get forumPostSubmit => 'Публикувай';

  @override
  String get forumPostTitleRequired => 'Дай заглавие на публикацията си.';

  @override
  String get forumPostMediaRequired =>
      'Добави поне едно изображение или видео, за да публикуваш тук.';

  @override
  String get forumPostContentRequired => 'Напиши съобщение или добави файл.';

  @override
  String get forumSortLatestActivity => 'Последна активност';

  @override
  String get forumSortCreationTime => 'Дата на публикуване';

  @override
  String get forumLayoutList => 'Изглед в списък';

  @override
  String get forumLayoutGallery => 'Изглед в галерия';

  @override
  String get forumNewPostsUnread => 'Показвай нови публикации като непрочетени';

  @override
  String get forumNewPostsUnreadDescription =>
      'Маркирай този канал като непрочетен, когато някой създаде публикация.';

  @override
  String get forumPostSlowmode => 'Бавен режим за публикации';

  @override
  String forumPostSlowmodeDescription(String bypassSlowmodePermissionLabel) {
    return 'Изчакване между създаването на публикации. „$bypassSlowmodePermissionLabel“ може да го заобиколи.';
  }

  @override
  String get forumMessageSlowmode => 'Бавен режим за съобщения в публикациите';

  @override
  String get forumMessageSlowmodeDescription =>
      'Бавен режим, прилаган към съобщенията в новите публикации.';

  @override
  String get forumDefaultAutoArchive => 'Скриване след неактивност';

  @override
  String get forumDefaultAutoArchiveDescription =>
      'Новите публикации се архивират след толкова време без активност.';

  @override
  String get forumDefaultReaction => 'Реакция по подразбиране';

  @override
  String get forumSetDefaultReaction => 'Избери емоджи';

  @override
  String get forumChangeDefaultReaction => 'Промени';

  @override
  String get forumRemoveDefaultReaction => 'Премахване';

  @override
  String get forumDefaultSortOrder => 'Подредба по подразбиране';

  @override
  String get forumDefaultLayout => 'Изглед по подразбиране';

  @override
  String get forumTagMatchSetting => 'Филтър по етикети';

  @override
  String get forumTagMatchSome => 'Съвпадение с който и да е избран етикет';

  @override
  String get forumTagMatchAll => 'Съвпадение с всички избрани етикети';

  @override
  String get forumRequireTag => 'Изисквай етикети';

  @override
  String get forumRequireTagDescription =>
      'Хората трябва да изберат поне един етикет, когато създават публикация.';

  @override
  String get forumHideMediaDownloads =>
      'Скриване на опциите за изтегляне на медии';

  @override
  String get forumHideMediaDownloadsDescription =>
      'Скрий изтеглянето, отварянето в браузър и копирането на връзка за изображенията и видеоклиповете в публикациите.';

  @override
  String forumTagsTitle(int count, int max) {
    return 'Етикети ($count/$max)';
  }

  @override
  String get forumTagsDescription =>
      'Етикетите помагат на хората да намират и филтрират публикации. Само модераторите могат да поставят модерирани етикети.';

  @override
  String get forumCreateTag => 'Създаване на етикет';

  @override
  String get forumEditTag => 'Редактиране на етикет';

  @override
  String get forumSaveTag => 'Запази етикета';

  @override
  String get forumDeleteTag => 'Изтриване на етикет';

  @override
  String get forumTagName => 'Име на етикет';

  @override
  String get forumTagEmoji => 'Емоджи';

  @override
  String get forumTagRemoveEmoji => 'Премахни емоджито';

  @override
  String get forumTagModerated => 'Само модераторите могат да го поставят';

  @override
  String get forumTagModeratedDescription =>
      'Само членове, които могат да управляват нишки, могат да поставят или премахват този етикет.';

  @override
  String get forumTagModeratedBadge => 'Модериран';

  @override
  String forumPostCooldown(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Можеш да публикуваш отново след $seconds секунди.',
      one: 'Можеш да публикуваш отново след 1 секунда.',
    );
    return '$_temp0';
  }

  @override
  String get voiceP2pStartTitle => 'Да се започне ли в P2P режим?';

  @override
  String voiceP2pStartDescription(int maxParticipants) {
    return 'Аудиото и видеото се предават директно между участниците с по-малко забавяне. Другите участници могат да видят IP адреса ти. Могат да участват до $maxParticipants души. Който не може да се свърже директно, не може да участва, докато някой не превключи към стандартен разговор.';
  }

  @override
  String get voiceP2pStartConfirm => 'Започни в P2P режим';

  @override
  String get voiceP2pStartStandard => 'Започни стандартен разговор';

  @override
  String get voiceP2pJoinTitle => 'Да се присъединиш ли към P2P разговор?';

  @override
  String voiceP2pJoinDescription(int maxParticipants) {
    return 'Този разговор свързва участниците директно. Другите участници могат да видят IP адреса ти. Могат да участват до $maxParticipants души. Ако не можеш да се свържеш директно, няма да можеш да участваш, докато някой не превключи към стандартен разговор.';
  }

  @override
  String voiceP2pPinnedJoinDescription(int maxParticipants) {
    return 'Този канал позволява само P2P разговори. Участниците се свързват директно и могат да видят IP адреса ти. Могат да участват до $maxParticipants души. Ако не можеш да се свържеш директно, няма да можеш да участваш.';
  }

  @override
  String get voiceP2pJoinConfirm => 'Присъединяване';

  @override
  String get voiceP2pAlwaysAgreeLabel =>
      'Не питай отново, винаги се съгласявай';

  @override
  String get voiceP2pAlwaysAgreeSettingLabel =>
      'Винаги приемай присъединяване към P2P разговори';

  @override
  String get voiceP2pAlwaysAgreeSettingDescription =>
      'Присъединявай се към P2P разговори без питане. Другите участници могат да видят IP адреса ти.';

  @override
  String get voiceP2pIndicatorLabel => 'P2P';

  @override
  String get voiceP2pIndicatorDescription =>
      'Директна връзка. Аудиото и видеото са шифровани между участниците.';

  @override
  String get voiceP2pSwitchToStandard => 'Превключи към стандартен разговор';

  @override
  String get voiceP2pSwitchToStandardDescription =>
      'Всички в разговора преминават към стандартен разговор през сървъра.';

  @override
  String get voiceP2pPeerFailedDescription =>
      'Не можа да се осъществи директна връзка. Напусни разговора или превключи всички към стандартен разговор.';

  @override
  String get voiceP2pUnavailableError =>
      'P2P разговорите в момента са недостъпни.';

  @override
  String get voiceP2pConsentRequiredError =>
      'Този разговор е P2P и изисква съгласието ти, за да се присъединиш.';

  @override
  String get voiceChannelFullError => 'Този разговор е пълен.';

  @override
  String get voiceP2pScreenShareUnavailable =>
      'Споделянето на екрана от това устройство не е налично в P2P разговори.';

  @override
  String get channelMenuJoinP2p => 'Започни P2P разговор';

  @override
  String get channelSettingsRtcP2pLabel => 'Само P2P разговори';

  @override
  String channelSettingsRtcP2pDescription(int maxParticipants) {
    return 'Участниците се свързват директно и могат да виждат IP адресите си един на друг. Всеки трябва да се съгласи, преди да се присъедини. Могат да участват до $maxParticipants души.';
  }

  @override
  String voiceP2pPeerFailedTitle(String name) {
    return 'Не може да се осъществи директна връзка с $name';
  }

  @override
  String get favoritesRenameCategory => 'Преименуване на категория';

  @override
  String get friendAcceptFailedTitle =>
      'Поканата за приятелство не можа да бъде приета';

  @override
  String get friendAcceptUnavailable =>
      'Тази покана за приятелство вече не е налична. Обнови и опитай отново.';

  @override
  String get friendAcceptClaimToAccept =>
      'Завърши регистрацията, за да приемаш покани за приятелство.';

  @override
  String get friendAcceptFailedMessage =>
      'Поканата за приятелство не можа да бъде приета. Опитай отново.';

  @override
  String get friendCancelFailedTitle =>
      'Поканата за приятелство не можа да бъде отменена';

  @override
  String get friendIgnoreFailedTitle =>
      'Неуспешно игнориране на покана за приятелство';

  @override
  String get friendIgnoreFailedMessage =>
      'Поканата за приятелство не можа да бъде игнорирана. Опитай отново.';

  @override
  String get friendRemoveFailedTitle => 'Неуспешно премахване на приятел';

  @override
  String get friendRemoveFailedMessage =>
      'Този приятел не можа да бъде премахнат. Опитай отново.';

  @override
  String get userBlockFailedTitle => 'Потребителят не можа да бъде блокиран';

  @override
  String get userBlockSystemAccount => 'Този акаунт не може да бъде блокиран.';

  @override
  String get userBlockFailedMessage =>
      'Потребителят не можа да бъде блокиран. Опитай отново.';

  @override
  String get userUnblockFailedTitle =>
      'Потребителят не можа да бъде отблокиран';

  @override
  String get userUnblockFailedMessage =>
      'Потребителят не можа да бъде отблокиран. Опитай отново.';

  @override
  String friendCancelRequestConfirmDescription(String userName) {
    return 'Да отмениш ли поканата за приятелство до $userName?';
  }

  @override
  String get errorSomethingWentWrongTitle => 'Нещо се обърка';

  @override
  String get errorUnexpectedTryAgain =>
      'Възникна неочаквана грешка. Опитай отново.';

  @override
  String get errorMessagingPausedTitle => 'Изпращането на съобщения е на пауза';

  @override
  String get errorMessagingPausedMessage =>
      'Изпращането на съобщения от акаунта ти е на пауза. Погледни имейла си: остава само една бърза стъпка, за да продължиш.';

  @override
  String get errorFeatureDisabledTitle => 'Функцията е временно деактивирана';

  @override
  String get errorFeatureDisabledMessage =>
      'Тази функция е поставена на пауза. Опитай отново по-късно.';

  @override
  String get dmErrorStartConversationTitle =>
      'Неуспешно започване на разговора';

  @override
  String get dmErrorCannotMessageMessage =>
      'Може да не приемат съобщения от теб или вече да нямате обща общност.';

  @override
  String get dmErrorUnknownUserMessage =>
      'Този потребител вече не съществува. Обнови и опитай отново.';

  @override
  String get dmErrorClaimMessage =>
      'Трябва да заявиш акаунта си, преди да можеш да започнеш директно съобщение.';

  @override
  String get dmErrorVerifyEmailMessage =>
      'Трябва да потвърдиш имейл адреса си, преди да можеш да започнеш директно съобщение.';

  @override
  String get dmErrorTooManyRecipientsTitle =>
      'Тази група има твърде много хора';

  @override
  String get dmErrorTooManyRecipientsMessage =>
      'Добавил си повече хора, отколкото позволява едно групово DM. Премахни няколко и опитай отново.';

  @override
  String get dmErrorMaxGroupDmsTitle => 'Достигна лимита за групови DM';

  @override
  String get dmErrorMaxGroupDmsMessage =>
      'Ти или някой, когото добавяш, вече има максималния брой отворени групови DM. Напусни едно и опитай отново.';

  @override
  String get groupDmAddFailedTitle => 'Неуспешно добавяне към групата';

  @override
  String get groupDmInviteFailedTitle =>
      'Неуспешно създаване на линк за покана';

  @override
  String get dmCloseFailedTitle => 'Неуспешно затваряне на DM';

  @override
  String get groupDmLeaveFailedTitle => 'Неуспешно напускане на групата';

  @override
  String get inviteJoinFailedTitle => 'Неуспешно присъединяване към общността';

  @override
  String get inviteErrorPausedMessage =>
      'Администраторите спряха поканите и в момента не можеш да се присъединиш.';

  @override
  String get inviteErrorAtCapacityTitle => 'Общността е пълна';

  @override
  String get inviteErrorAtCapacityMessage =>
      'Тази общност е достигнала максималния си лимит за членове и в момента не приема нови членове.';

  @override
  String get inviteErrorPresenceTitle => 'Изисква се активна връзка';

  @override
  String get inviteErrorPresenceMessage =>
      'Временните покани изискват активна връзка. Провери връзката си и опитай отново.';

  @override
  String get inviteErrorBannedTitle => 'Наложена ти е забрана';

  @override
  String get inviteErrorBannedMessage =>
      'Наложена ти е забрана в тази общност и не можеш да се присъединиш.';

  @override
  String get inviteErrorIpBannedTitle => 'На IP адреса ти е наложена забрана';

  @override
  String get inviteErrorIpBannedMessage =>
      'На IP адреса ти е наложена забрана в тази общност и не можеш да се присъединиш.';

  @override
  String get inviteErrorClaimTitle => 'Изисква се потвърждение на акаунта';

  @override
  String get inviteErrorClaimMessage =>
      'Първо добави имейл и парола към акаунта си.';

  @override
  String get leaveCommunityFailedTitle => 'Неуспешно напускане на общността';

  @override
  String get leaveCommunityFailedMessage =>
      'В момента напускането не е възможно. Опитай отново след малко.';

  @override
  String get chatSendFailedTitle => 'Съобщението ти не беше изпратено';

  @override
  String get chatSendFailedMessage =>
      'Опитай да изпратиш съобщението си отново.';

  @override
  String get chatSendTooQuickTitle => 'Изпращаш съобщения твърде бързо';

  @override
  String get chatRateLimitedMessage =>
      'По-бавно — изчакай малко, преди да опиташ отново.';

  @override
  String get chatMatureContentTitle =>
      'Съдържанието за възрастни не е позволено';

  @override
  String get chatMatureContentGuildMessage =>
      'Този канал не е маркиран за съдържание за възрастни. Съдържание за възрастни може да се изпраща само в канали, маркирани за съдържание за възрастни. Помоли модератор да обнови този канал, ако е уместно.';

  @override
  String chatMatureContentDmMessage(String settingsPath) {
    return 'Ти или човекът, с когото пишеш, сте избрали да блокирате чувствителни медии в директните съобщения. Всеки от вас може да промени това в $settingsPath.';
  }

  @override
  String get chatMatureContentGroupDmMessage =>
      'Тази група не е маркирана за съдържание за възрастни. Собственикът на групата може да включи „Съдържание за възрастни“ в настройките на групата, ако всички в нея са навършили 18 години.';

  @override
  String get chatFileTooLargeTitle => 'Файлът е твърде голям';

  @override
  String chatFileTooLargeMessage(String maxSize) {
    return 'Един или повече файлове, които се опитваш да качиш, надвишават максималния размер от $maxSize на файл.';
  }

  @override
  String get chatHeavyTitle => 'Леле, това е тежко';

  @override
  String get chatReactionsHeavyMessage =>
      'Това е доста тежко съобщение. Някои реакции трябва да бъдат премахнати, преди да можеш да добавиш още.';

  @override
  String get chatReactionTimedOut =>
      'Не можеш да добавяш нови реакции, докато си с наложено време за изчакване.';

  @override
  String chatTooManyAttachmentsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла',
      one: '$count файл',
    );
    return 'Можеш да качваш само $_temp0 наведнъж. Опитай отново с по-малко файлове.';
  }

  @override
  String get chatEditTooQuickTitle => 'Редактираш съобщения твърде бързо';

  @override
  String get chatEditFailedMessage =>
      'Опитай да редактираш съобщението си отново.';

  @override
  String get chatDeleteTooQuickTitle => 'Изтриваш съобщения твърде бързо';

  @override
  String get chatDeleteTooQuickMessage =>
      'Изчакай малко, преди да изтриеш още съобщения.';

  @override
  String get chatDeleteFailedTitle => 'Съобщението не можа да бъде изтрито';

  @override
  String get chatDeleteFailedMessage => 'Опитай да изтриеш съобщението отново.';

  @override
  String get chatAttachmentDeleteFailedTitle =>
      'Прикаченият файл не можа да бъде изтрит';

  @override
  String get chatAttachmentDeleteFailedMessage =>
      'Опитай отново да изтриеш този прикачен файл.';

  @override
  String get chatAltTextFailedTitle =>
      'Неуспешно актуализиране на алтернативния текст';

  @override
  String get chatAltTextUnknownMessage => 'Това съобщение вече не съществува.';

  @override
  String get chatAltTextNoPermission =>
      'Не можеш да редактираш това съобщение.';

  @override
  String get chatAltTextUnavailable =>
      'Редактирането е временно недостъпно. Опитай отново по-късно.';

  @override
  String get chatAltTextFailedMessage =>
      'Алтернативният текст не можа да бъде актуализиран. Опитай отново.';

  @override
  String get chatPinFailedTitle => 'Неуспешно закачане на съобщението';

  @override
  String get chatUnpinFailedTitle => 'Неуспешно откачане на съобщението';

  @override
  String get chatPinFailedMessage => 'Нещо се обърка. Опитай отново по-късно.';

  @override
  String get chatPinBlockedMessage =>
      'В момента не можеш да взаимодействаш с този потребител.';

  @override
  String get bookmarkLimitTitle => 'Достигнат лимит за отметки';

  @override
  String bookmarkLimitMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count отметки',
      one: '$count отметка',
    );
    return 'Достигна лимита от $_temp0. Премахни една, за да добавиш друга.';
  }

  @override
  String get savedMediaLimitTitle => 'Достигнат е лимитът за запазени медии';

  @override
  String savedMediaLimitMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count запазени медийни файла',
      one: '$count запазен медиен файл',
    );
    return 'Достигна лимита от $_temp0. Премахни един, за да добавиш друг.';
  }

  @override
  String get errorContentBlockedTitle => 'Съдържанието е блокирано';

  @override
  String get errorContentBlockedMessage =>
      'Действието ти не можа да бъде извършено, защото беше отбелязано от системите ни за безопасност. Ако смяташ, че това е грешка, свържи се с поддръжката.';

  @override
  String get errorContentBlockedSelfHostedMessage =>
      'Действието ти не можа да бъде извършено, защото беше отбелязано от системите ни за безопасност. Ако смяташ, че това е грешка, свържи се с администраторите на тази инстанция.';

  @override
  String get channelDeletedToast => 'Каналът е изтрит';

  @override
  String get categoryDeletedToast => 'Категорията е изтрита';

  @override
  String get channelDeleteNoPermissionTitle => 'Не можеш да изтриеш това';

  @override
  String get channelDeleteNoPermissionChannel =>
      'Нямаш разрешение да изтриеш този канал.';

  @override
  String get channelDeleteNoPermissionCategory =>
      'Нямаш разрешение да изтриеш тази категория.';

  @override
  String get channelDeleteAlreadyDeletedTitle => 'Вече не съществува';

  @override
  String get channelDeleteAlreadyDeletedChannel =>
      'Този канал вече не съществува. Може вече да е бил изтрит.';

  @override
  String get channelDeleteAlreadyDeletedCategory =>
      'Тази категория вече не съществува. Може вече да е била изтрита.';

  @override
  String get channelDeleteFailedChannelTitle =>
      'Каналът не можа да бъде изтрит';

  @override
  String get channelDeleteFailedCategoryTitle =>
      'Неуспешно изтриване на тази категория';

  @override
  String get channelPermissionsUpdateFailedTitle =>
      'Неуспешно актуализиране на разрешенията за канала';

  @override
  String get channelSettingsSaveFailedTitle =>
      'Настройките на канала не можаха да бъдат запазени';

  @override
  String get emojiSlotsFullTitle => 'Няма свободни слотове за емоджита';

  @override
  String get stickerSlotsFullTitle => 'Няма свободни слотове за стикери';

  @override
  String get emojiSomeFailedMessage =>
      'Прегледай тези файлове и опитай отново с по-малки или по-прости изображения.';

  @override
  String get emojiNameInvalidCharacters =>
      'Имената на емоджитата могат да съдържат само букви, цифри и долни черти.';

  @override
  String get emojiErrorGoneTitle => 'Това емоджи вече не съществува';

  @override
  String get emojiRenameGoneMessage =>
      'Възможно е да е било изтрито. Името беше върнато към предишното.';

  @override
  String get emojiRenameNoPermissionTitle =>
      'Не можеш да преименуваш това емоджи';

  @override
  String get emojiRenameNoPermissionMessage =>
      'Нямаш разрешение да преименуваш това емоджи. Името беше върнато към предишното.';

  @override
  String get emojiRenameRateLimitedMessage =>
      'Изчакай малко и опитай да преименуваш отново.';

  @override
  String get emojiRenameFailedMessage =>
      'Името беше върнато към предишното. Опитай отново след малко.';

  @override
  String get emojiDeleteGoneMessage => 'Изглежда, че вече е изтрито.';

  @override
  String get emojiDeleteNoPermissionTitle => 'Не можеш да изтриеш това емоджи';

  @override
  String get emojiDeleteNoPermissionMessage =>
      'Нямаш разрешение да изтриеш това емоджи.';

  @override
  String get emojiDeleteRateLimitedMessage =>
      'Изчакай малко и опитай да изтриеш отново.';

  @override
  String get stickerTooLargeTitle => 'Стикерът е твърде голям';

  @override
  String stickerTooLargeMessage(String maxSize) {
    return 'Услугата за качване отхвърли този стикер, тъй като е по-голям от $maxSize. Опитай с по-малък файл, по-опростено изображение или по-кратка анимация.';
  }

  @override
  String get stickerCreateFailedMessage =>
      'Нещо се обърка при подготовката на този стикер. Опитай друг файл или опитай отново след малко.';

  @override
  String get stickerUpdateFailedTitle =>
      'Стикерът не можа да бъде актуализиран';

  @override
  String get moderationTimeoutFailed =>
      'Неуспешно налагане на време за изчакване на члена. Опитай отново.';

  @override
  String get moderationRemoveTimeoutFailed =>
      'Неуспешно премахване на времето за изчакване. Опитай отново.';

  @override
  String get moderationKickFailed =>
      'Неуспешно изгонване на члена. Опитай отново.';

  @override
  String get moderationBanFailed =>
      'Неуспешно забраняване на достъпа на члена. Опитай отново.';

  @override
  String get transferOwnershipFailedTitle =>
      'Неуспешно прехвърляне на собствеността';

  @override
  String transferOwnershipFailedMessage(String username) {
    return 'В момента собствеността не може да бъде прехвърлена на $username.';
  }

  @override
  String get revokeBanFailedTitle => 'Неуспешно отменяне на забраната';

  @override
  String get voiceModerationNoPermissionTitle => 'Не можеш да направиш това';

  @override
  String get voiceModerationNoPermissionMessage =>
      'Нямаш разрешение да извършиш това действие с този член.';

  @override
  String get voiceModerationLeftTitle => 'Участникът напусна разговора';

  @override
  String get voiceModerationLeftMessage =>
      'Този член вече не е свързан с гласов канал.';

  @override
  String get voiceModerationUnknownMemberTitle => 'Членът не е намерен';

  @override
  String get voiceModerationUnknownMemberMessage =>
      'Този член вече не е в общността. Обнови и опитай отново.';

  @override
  String get voiceJoinTimedOut =>
      'Не можеш да се присъединиш, докато си с наложено време за изчакване.';

  @override
  String get voiceJoinClaimAccount =>
      'Заяви акаунта си, за да се присъединиш към този гласов канал.';

  @override
  String get voiceJoinClaimAccountDirectCall =>
      'Заяви акаунта си, за да започваш или да се присъединяваш към разговори 1:1.';

  @override
  String get voiceJoinUserLimit =>
      'Този гласов канал е достигнал лимита си за потребители. Опитай отново по-късно или се присъедини към друг канал.';

  @override
  String get voiceJoinConnectionLimit =>
      'Достигна лимита за връзки в този гласов канал.';

  @override
  String get voiceJoinChannelUnavailable =>
      'Този гласов канал вече не е наличен.';

  @override
  String get avatarUploadFailedTitle => 'Неуспешно качване на аватара';

  @override
  String get bannerUploadFailedTitle => 'Неуспешно качване на банер';

  @override
  String get animatedImageUseStatic => 'Вместо това качи статично изображение.';

  @override
  String get passkeyDeleteFailedTitle =>
      'Неуспешно изтриване на ключ за достъп';

  @override
  String get premiumPaymentsUnavailableTitle => 'Плащанията не са налични';

  @override
  String get premiumPaymentsUnavailableMessage =>
      'Плащанията временно не са налични. Опитай отново след малко.';

  @override
  String get premiumNoSubscriptionTitle => 'Няма активен абонамент';

  @override
  String get premiumNoSubscriptionMessage =>
      'Не успяхме да намерим активен абонамент за този акаунт. Презареди и опитай отново.';

  @override
  String get premiumAlreadyCancelingTitle => 'Анулирането вече е насрочено';

  @override
  String get premiumAlreadyCancelingMessage =>
      'Абонаментът ти вече е настроен да се анулира в края на периода ти на таксуване.';

  @override
  String get premiumNotCancelingTitle =>
      'Абонаментът не е насрочен за анулиране';

  @override
  String get premiumNotCancelingMessage =>
      'Абонаментът ти не е настроен за анулиране, така че няма какво да активираш отново.';

  @override
  String get premiumCancelFailedTitle =>
      'Абонаментът ти не можа да бъде анулиран';

  @override
  String get premiumCancelFailedMessage =>
      'Нещо се обърка при анулирането на абонамента ти. Опитай отново след малко.';

  @override
  String get premiumReactivateFailedTitle =>
      'Абонаментът ти не можа да бъде активиран отново';

  @override
  String get premiumReactivateFailedMessage =>
      'Нещо се обърка при повторното активиране на абонамента ти. Опитай отново след малко.';

  @override
  String get premiumRefundConfirmTitle =>
      'Да възстановим ли сумата за последната ти покупка?';

  @override
  String get premiumRefundConfirmBody =>
      'Това възстановява сумата по последната ти фактура и анулира всички свързани абонаменти. Няма да можеш да поискаш ново самостоятелно възстановяване в следващите 30 дни.';

  @override
  String get premiumRefundConfirm => 'Възстановяване на сума за покупка';

  @override
  String get premiumRefundIssuedToast =>
      'Възстановяването е извършено. Може да отнеме няколко работни дни, докато се появи.';

  @override
  String get premiumRefundOutsideWindowTitle =>
      'Извън срока за възстановяване на сума';

  @override
  String get premiumRefundOutsideWindowMessage =>
      'Последната ти покупка вече не е в срока за възстановяване на сума. Свържи се с поддръжката при проблеми с таксуването.';

  @override
  String get premiumRefundCooldownTitle => 'Наскоро заяви възстановяване';

  @override
  String get premiumRefundCooldownMessage =>
      'Наскоро вече възстанови сума самостоятелно. Можеш да го направиш отново, след като изтече периодът на изчакване.';

  @override
  String get premiumRefundNothingTitle => 'Няма нищо за възстановяване';

  @override
  String get premiumRefundNothingMessage =>
      'Не успяхме да намерим скорошна покупка за възстановяване на сума по този акаунт.';

  @override
  String get premiumRefundFailedTitle =>
      'Неуспешно възстановяване на сумата за тази покупка';

  @override
  String get premiumRefundFailedMessage =>
      'Нещо се обърка при възстановяването на сумата. Свържи се с поддръжката, ако това продължава да се случва.';

  @override
  String get premiumVerifyEmailTitle => 'Първо потвърди имейла си';

  @override
  String premiumVerifyEmailBody(String productName) {
    return 'Трябва да потвърдиш имейла си, преди да можеш да закупиш $productName.';
  }

  @override
  String get premiumCheckoutBlockedTitle => 'Плащането е недостъпно';

  @override
  String premiumCheckoutBlockedBody(String supportEmail) {
    return 'Плащането е блокирано за този акаунт. Свържи се с $supportEmail, ако имаш нужда от помощ.';
  }

  @override
  String get premiumCheckoutBlockedBodySelfHosted =>
      'Плащането е блокирано за този акаунт.';

  @override
  String get advancedPerformanceReportingSectionDescription =>
      'Help improve echowire by sharing anonymous crash and performance data.';

  @override
  String get advancedPerformanceReportingDescription =>
      'All reported data is anonymous and is sent only to echowire\'s own monitoring service — no third-party providers are used.';

  @override
  String get captchaTitle => 'Потвърдете, че сте човек';

  @override
  String get captchaDescription =>
      'Трябва да се уверим, че не сте бот. Моля, завършете проверката по-долу.';

  @override
  String get captchaSwitchToHcaptcha =>
      'Имате проблеми? Опитайте hCaptcha вместо това';

  @override
  String get captchaSwitchToTurnstile => 'Опитай Turnstile вместо това';

  @override
  String get phoneCaptchaRequired =>
      'Необходима е проверка на браузъра, преди да потвърдите телефона си. Опитайте отново от страницата за вход или се свържете с поддръжката.';

  @override
  String get advancedSettingShowNekoKeywordCat => 'котка';

  @override
  String get advancedSettingShowNekoKeywordNeko => 'Neko';

  @override
  String get threadsAddMember => 'Add member';

  @override
  String get threadsAddMemberSearchLabel => 'Search members';

  @override
  String get threadsAddMemberNoResults => 'No members match that search.';

  @override
  String get threadsMemberAddedToast => 'Member added';
}
