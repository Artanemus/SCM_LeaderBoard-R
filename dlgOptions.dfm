object Options: TOptions
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'LeaderBoard options ...'
  ClientHeight = 592
  ClientWidth = 894
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object lblSessionCaption: TLabel
    Left = 220
    Top = 67
    Width = 137
    Height = 19
    Alignment = taCenter
    Caption = 'Session Description'
  end
  object Label2: TLabel
    Left = 60
    Top = 24
    Width = 151
    Height = 19
    Alignment = taRightJustify
    Caption = 'Swimming session ...'
  end
  object Label3: TLabel
    Left = 63
    Top = 313
    Width = 150
    Height = 19
    Alignment = taRightJustify
    Caption = 'Entrant'#39's age as of ...'
  end
  object Label4: TLabel
    Left = 56
    Top = 459
    Width = 158
    Height = 19
    Alignment = taRightJustify
    Caption = 'Placement given on ...'
  end
  object lblStartOfSwimmingSeacon: TLabel
    Left = 220
    Top = 92
    Width = 98
    Height = 19
    Caption = 'DD/MM/YYYY'
  end
  object Label5: TLabel
    Left = 58
    Top = 426
    Width = 156
    Height = 19
    Alignment = taRightJustify
    Caption = 'Score calculated on ...'
  end
  object Label7: TLabel
    Left = 88
    Top = 137
    Width = 125
    Height = 19
    Alignment = taRightJustify
    Caption = 'Range to score ...'
  end
  object lblAutoUpdate1: TLabel
    Left = 611
    Top = 437
    Width = 107
    Height = 19
    Alignment = taRightJustify
    Caption = 'Update interval'
    Enabled = False
  end
  object lblAutoUpdate2: TLabel
    Left = 789
    Top = 437
    Width = 68
    Height = 19
    Caption = '(minutes)'
    Enabled = False
  end
  object Label8: TLabel
    Left = 286
    Top = 167
    Width = 143
    Height = 19
    Alignment = taRightJustify
    Caption = 'Custom date from...'
  end
  object Label9: TLabel
    Left = 286
    Top = 230
    Width = 123
    Height = 19
    Alignment = taRightJustify
    Caption = 'Custom date to...'
  end
  object Label10: TLabel
    Left = 232
    Top = 343
    Width = 201
    Height = 19
    Alignment = taRightJustify
    Caption = 'Custom seed date for age ...'
  end
  object Label11: TLabel
    Left = 66
    Top = 67
    Width = 148
    Height = 19
    Alignment = taRightJustify
    Caption = 'Session Description :'
  end
  object Label12: TLabel
    Left = 16
    Top = 92
    Width = 198
    Height = 19
    Alignment = taRightJustify
    Caption = 'Start of Swimming Season :'
  end
  object imgDateFrom: TVirtualImage
    Left = 442
    Top = 192
    Width = 32
    Height = 32
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 3
    ImageName = 'today_FILL0_wght700_GRAD0_opsz48'
    OnClick = imgDateFromClick
  end
  object imgDateTo: TVirtualImage
    Left = 442
    Top = 255
    Width = 32
    Height = 32
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 3
    ImageName = 'today_FILL0_wght700_GRAD0_opsz48'
    OnClick = imgDateToClick
  end
  object imgAgeSeedDate: TVirtualImage
    Left = 443
    Top = 368
    Width = 32
    Height = 32
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 3
    ImageName = 'today_FILL0_wght700_GRAD0_opsz48'
    OnClick = imgAgeSeedDateClick
  end
  object vimgAutoUpdate: TVirtualImage
    Left = 540
    Top = 401
    Width = 48
    Height = 48
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 5
    ImageName = 'timer_off_FILL0_wght500_GRAD0_opsz48'
    OnClick = vimgAutoUpdateClick
  end
  object Label1: TLabel
    Left = 572
    Top = 167
    Width = 250
    Height = 38
    Caption = 
      'The minimum heat status required before a heat will be considere' +
      'd.'
    Enabled = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 540
    Top = 368
    Width = 139
    Height = 19
    Caption = 'SCOREBOARD  ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 534
    Width = 894
    Height = 58
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    BevelWidth = 2
    TabOrder = 0
    object btnClose: TButton
      Left = 795
      Top = 11
      Width = 75
      Height = 33
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 714
      Top = 11
      Width = 75
      Height = 33
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object cbSessionStart: TComboBox
    Left = 220
    Top = 24
    Width = 255
    Height = 27
    Style = csDropDownList
    DropDownCount = 12
    TabOrder = 1
    OnChange = cbSessionStartChange
  end
  object cbxCalcEntrantAge: TComboBox
    Left = 219
    Top = 310
    Width = 254
    Height = 27
    Style = csDropDownList
    TabOrder = 2
    Items.Strings = (
      'Start of swimming season'
      'Current session'
      'Custom seed date')
  end
  object cbxCalcByEvent: TComboBox
    Left = 220
    Top = 456
    Width = 255
    Height = 27
    Style = csDropDownList
    TabOrder = 3
    Items.Strings = (
      'HEAT'
      'EVENT')
  end
  object cbxCalcRange: TComboBox
    Left = 219
    Top = 134
    Width = 255
    Height = 27
    Style = csDropDownList
    TabOrder = 4
    OnChange = cbxCalcRangeChange
    Items.Strings = (
      'Start of season to selected'
      'Selected session only'
      'Custom date range')
  end
  object cbxCalcRelative: TComboBox
    Left = 220
    Top = 423
    Width = 255
    Height = 27
    Style = csDropDownList
    TabOrder = 5
    Items.Strings = (
      'ABSOLUTE'
      'RELATIVE TO DIVISION')
  end
  object spinedtAutoUpdateInterval: TSpinEdit
    Left = 725
    Top = 434
    Width = 58
    Height = 29
    Enabled = False
    MaxValue = 60
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object chbxAutoUpdate: TCheckBox
    Left = 594
    Top = 401
    Width = 255
    Height = 20
    Action = actnAutoUpdate
    TabOrder = 7
  end
  object calDateFrom: TCalendarPicker
    Left = 296
    Top = 192
    Height = 32
    CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
    CalendarHeaderInfo.DaysOfWeekFont.Height = -13
    CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    CalendarHeaderInfo.DaysOfWeekFont.Style = []
    CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.Font.Color = clWindowText
    CalendarHeaderInfo.Font.Height = -20
    CalendarHeaderInfo.Font.Name = 'Segoe UI'
    CalendarHeaderInfo.Font.Style = []
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    TextHint = 'select a date'
  end
  object calDateTo: TCalendarPicker
    Left = 296
    Top = 255
    Height = 32
    CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
    CalendarHeaderInfo.DaysOfWeekFont.Height = -13
    CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    CalendarHeaderInfo.DaysOfWeekFont.Style = []
    CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.Font.Color = clWindowText
    CalendarHeaderInfo.Font.Height = -20
    CalendarHeaderInfo.Font.Name = 'Segoe UI'
    CalendarHeaderInfo.Font.Style = []
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    TextHint = 'select a date'
  end
  object calAgeSeedDate: TCalendarPicker
    Left = 297
    Top = 368
    Height = 32
    CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
    CalendarHeaderInfo.DaysOfWeekFont.Height = -13
    CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    CalendarHeaderInfo.DaysOfWeekFont.Style = []
    CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
    CalendarHeaderInfo.Font.Color = clWindowText
    CalendarHeaderInfo.Font.Height = -20
    CalendarHeaderInfo.Font.Name = 'Segoe UI'
    CalendarHeaderInfo.Font.Style = []
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    TextHint = 'select a date'
  end
  object cbxIncludeLockedSessions: TCheckBox
    Left = 570
    Top = 29
    Width = 219
    Height = 20
    Caption = 'Include locked sessions.'
    TabOrder = 11
  end
  object CheckBox2: TCheckBox
    Left = 570
    Top = 110
    Width = 287
    Height = 38
    Caption = 
      'ALL heats must be RACED for an event to be scored. (Fully timed.' +
      ')'
    Enabled = False
    TabOrder = 12
    WordWrap = True
  end
  object ComboBox1: TComboBox
    Left = 572
    Top = 211
    Width = 87
    Height = 27
    AutoDropDown = True
    Style = csDropDownList
    Enabled = False
    ItemIndex = 0
    TabOrder = 13
    Text = 'OPEN'
    Items.Strings = (
      'OPEN'
      'RACED'
      'CLOSED')
  end
  object CheckBox3: TCheckBox
    Left = 570
    Top = 255
    Width = 285
    Height = 43
    Caption = 'Enable warnings for long processing times. '
    Enabled = False
    TabOrder = 14
    WordWrap = True
  end
  object CheckBox4: TCheckBox
    Left = 570
    Top = 69
    Width = 219
    Height = 21
    Caption = 'Group by gender.'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 15
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'outline_refresh_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              3800000316494441547801EDDC03AC644B1446E167DBB6836705CFB615DD3879
              D6D86638B61D8C6DDBB66D7BCF1AC5395D7DEF4175CDBF922FE6AE7657D5454A
              29A594524A29A594524A29A594521E741BBE452574C374ACC246180C1BB10AD3
              D11515F10D6E4592554190BD8886980B2BA1D9A887E71218BE2198AEC77F5800
              4BC81CFC856BE2193E02E82654C10E584AB6A21CAE2FE1F051D815612B2C231B
              F17309868FC2EC618C83796238EECF7FF828C0BEC56E9867B6E3933C878FC2E9
              62D48779EC24AABA0F1F05D265E8082BA62DE88EBFF0091EC35D38DFDD781C9F
              E21FF4C24E5831B5C0A50EC347610CBF2F2C4F3BD018AFA2385D8C37D116FB61
              799A0F73E07517A3032C0F9BF02FAE455CDD82EA89BCF7785E1D98A3A36880EB
              905477A0E385B2005FE124CCC132BC80B4FA04DB435E8007B113E6A00F6E40DA
              DD8FE9A12EC048988356B81459753D4684B600BF380FDF8F6A84B400D763A3E3
              CBCEA5C8BA2AA1BD0495757CC3BD2190E1C39FAEC116878F9A2F04347CF8D36F
              B01C1A06367CF8D37487DFDEAF0B6CF8F0A3676039FC1BE0F0E147351D7E58BB
              36C0E1C38F26C322340E73F8F0A01B700C16E1D530870F0FFAD8E1CF948BC31C
              3E3CE87F5884EEE10E1F1ED40A16E1EF70870F0F1A038BF0115452396C257C0C
              2AC1D6C022DC0A95603B6111AE40706901945E82F426ACF431545FC494C34F11
              21A71FE394FBCFD1CAFF3F643CAA2D2CC27890FE924CA23B711816A134487FCA
              275155580E4F82B42D25EE6EC65658840920D2C6ACD86B0DCBA108CE696BA27B
              6F3B1C2AD980ABE09436E7BA773396C172F80B4E697BBA7B57620C2C8735B81A
              31A6031A17A31BCCC1B788311D51BA1CED600E0621C67448EF568C8639D886BB
              11533AA6FA2A96C11C9CC41788211DD4BE192D7002E6A82262485715FC8BADB0
              3CB44709D2651DAFA10D0EC2F2D40D972247BAAEE64A3C8497F01ECA6000F6C0
              8AA95316C3D7854D40356490AE2CDB85EF9041BAB46F0C1E44CAE9DACAAD2842
              CAE9E2D69DA88C1B9162BABA7821FE4E77F0BABC7B31EAE0758D35B9EBEB7762
              15A6A03B6AE14BDC09A594524A29A594524A29A594524AA94C3B05156E0E9530
              9D467A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_watch_later_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              38000003F4494441547801ECDB01445D5118C0F14D6F3516DEF6562F900CC013
              1216235129660124780C44C1A809987A60220A6518A4064A33480006A4B24C25
              AC3B90D4221ACBF2DEB73F3660EE776FF79DDEB9EFDC3F3F00D2C7B99D734E77
              2C2B2929292929292929292929298D5E8C6216EBD8838763C85FC7F0B08775CC
              6214BD4823604975E8C334B650824454C216A6D1873AE839560716700E31EC1C
              0BE880D3A590C73EA442F691470ACE740FC3F02096F0308C7BA8EABA7000B1D4
              01BA507565B104898925645115F5E004123327E8416CAB41014548046758C514
              06D1861634E15F4D68411B063185559C412228A2801AC4AA7A6C406E681BE368
              45D45A318E6DC80D6DA01EB1A8019B90902E31831C4C95C30C2E21216DA20156
              D78C43480817282083DB2A83022E20211CA21956F6F806BFFC4534A2523562F1
              0643780CABAA0FB9EC78E8842D75C20BB91CD5C38A6A427E70D790866DA5B116
              F2C35C838A5708712A3901DB9B08710A5BB06193558428AE91475CCAE31AA228
              5672B396C549C05FFE00E2D640C0219C54EAD86239E0B293475CCB075C8E962B
              71AA5982282610F726208AD26D9EA2D606BC44598389E4BFCCB616F072A716C6
              1B86283CA4AB6800697810C5308C960AF08394D0098AD700943A032CBB1E5230
              561EA25804C573004A8B10451E86D2D7FE0B64AB7800595CA8DF024375401453
              A0780F40690AA2E840D99B0F709E9F7160009900F709F3065EACA98FA66640D5
              3100A599008FBFEA50B6FA218A9C4303C84114FD285BD3101F3B20470640B403
              F1318D32A55F688F39388031FD6141797A14E0C8B9D5C101B40638AA7E84C875
              437C9CE2AE8303B88B53888F6E446E04E26305E4D8008856203E4610B939888F
              4987073009F1318788E917EE430E0F6048BFB88FDE2EC447BBC3036887F8D845
              E48E203E5A1C1E400BC4C71122A7BD30CE383C808CFEB23B7A57101FB50E0FA0
              16E2E3CAA501DCB771002E2D41DFF0DCB625A82A3FC28A4F7812FF8FB0CD7F86
              EA7EE10DEEDBF76768FC37622FF01DA25096256B3762161C45E83DC05BFC8654
              6E59D28F22E27D18A797C367F3CB92F9C338BB8FA3F55EE287F965C9FC71B4BD
              17327A19BC47C9FCB264FE42C6DE2B49BD67F86A7E59D2AF24EDBF9437570AAF
              F1D3E0B2A45FCADBFF2CC578CDF80809E883816729763ECCB274EFF0CAC0C32C
              3B9F265AB877F8829481A789763ECEB56CEF50C453038F73ED7E9E6ED1DEE19D
              FDCFD32DF8070D0365308B8771F9078D3FEDDD310100000CC230FFAEE7623D48
              7C50FA8952A79F286523BD4030D20B66AA817EA6DA0FB50DB5A50A8254815847
              10EB90AB09723501C1A69864594FB4AF275BD9136EED491787C4BB03F2F50107
              0E01172601273E0137563B1CB9B932C499E73377B6000000079195108DDCF254
              E20000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_date_range_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001184944415478DAEDDB3B0EC2400C45D157003BA1817DD20122623320
              B1025AD8037510FFC0502121285032F9D8E13E9791323EC5C8CD5822841042F2
              247C94B5FF0100000000807233D4545BEDBF0EAABA526D35D120AEF98E1265B5
              B7FE5E9912758BB7BF68B4F9572D8B12C626DA0F0A9A1569BFAFAB194056E42E
              8CCCB41F1434C90F589B026CF20376A600697EC0A1EE0959F680030020F2FC23
              0000004CD5FF014E000000F00D38B70DE06E90010050312034FCFD672E000000
              F00DB802300E303FC80000883CFF06000000DF800C000000001A05DC010000E0
              1BF0000000806F40000020EEFCD4FBC3D78DF7A7C753EF8FBF870DEF6E443FBF
              97E6BE1720A49E56BE5750A49EE69E97805E77C1F11A16218490B6E709CDA0BC
              2B579CFE700000000049454E44AE426082}
          end>
      end
      item
        Name = 'today_FILL0_wght700_GRAD0_opsz48'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE9000001F6494441546843ED99FF31053110C7
              BFAF023A4005A8001DE80015A00274A0035A50012AF0744005E8C07C66DECD44
              DEFDC86D12377997FC7993DDEC77F79BBDCDEE4285AF45E1F6CB02E040D29603
              FC5DD2B7D111DB92F61DD91F49CB31BA2C005E241D39879C48E29B651D4B7A76
              045F25F12D78CD02C0AEA41DC725F792A051B3AEC686DD91450FFA9A057DD0D7
              AC4F491F7DE1E88B00CA1F3C6383439B7023A02EBA9CD40500E3DF121A9142D5
              611B882E0018EFD2248501B13A880420FEAC3600A4B6AFD8D332C9EFF977A20D
              809FDAB085F4664D95562CD8E1A66BF4ACA5EC500077926EAD9618E538EFC693
              AD008CCE3489D508B86E2BFE0E9081A6C8427E6167BEC4261267109A2F80FA23
              33D0A9A6D18D4AA35DFF014AEECB55E9CDC39ED7137B7B5F518174CA4EA1F3D5
              8BCDB70720D7921E030DEDDA9615C0D08B0D103C3E6222911500DE3D1BF0706C
              F9911540C89373748FC7734856007E73AB2D184F924E23EE415600C553886617
              5D02B747EA3A9B1E277BAC3D5374658D00079046E9AAF920301EEAC496DFD901
              00022F0384BA1D6F131540C578BE89E4BF0088B8A383A215C02C8AB9411E446C
              A814AA148AA04FF21F59517DA1E2E703848F3FAA3BBF8D64431271E6D16B53A3
              8D9D91E132D052364F1D093C4FBDD53AC10F19747327A61AF861746F61180220
              09817329291EC02F6FA6BA319D4753F70000000049454E44AE426082}
          end>
      end
      item
        Name = 'leaderboard_FILL0_wght500_GRAD0_opsz48'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000011B494441546843ED59DB11C22010DC
              54A09D68075A92A5589276A09D980E1447674EC9048E032F319BDF1C13F6416E
              810E337FBA99CF1F04E0AD2015F807058E00368540AE000E85639FC36A58E804
              6057388933807DE1580278132715E8015C128C6E01AC5E35935320674212704E
              FD281FB5D740CE8408404A420500682DA1ADE71A48F5192DA3DAFAE529A0CD36
              A131AD158DA9B902ADB30D01A4FA40EB6CF353055A440309E09611FE24E1D1FE
              61A8136B19B2D4A77ED1DFEF234209C01825CCFB076F05CC6B8C008C16A202B4
              102D943ED81A6D94B4102D440BC579D0922ECD8D69209E9A16714E5E977BE2D6
              F5EA38ADCDEBADEB9701201CAB045B4CF109770F1F5752350E775D8112802BFD
              956E295D31D042AEF43F3E7E07CB4FC631B90D184E0000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'timer_off_FILL0_wght500_GRAD0_opsz48'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000388494441546843ED998F910D4110C6
              BF8B00112002448008100122400488001170112002448008900111503FB553D5
              D7D733D3BDBB4FDD55E9AA57F5EEDECC6C7FDD5FFF99DE239D7339DA49FF8B92
              AE15CFFA2AE96771CFA9E57B01B825E9435199DB923E16F7FC07D033D899F300
              9CDECCCFADF4C8EC8F62E0B5A4EB92E0E89907E101A0FC8305F997F300C20378
              23E9BE715D05045EBB238978E03B34B48237398FCCF37EF99E61C9704D44A10A
              08947CB478ED4A519BEF925E4A3AEE5015434CD36CAF0E6440DC9504E5BCA58B
              38FEC6D93349AFCCC646E58792D0A52BA342360381E258C856E05F86268D32AC
              835248A359A4D03B4928FCC2C421EBEE49E2B7506695380B0225B1E2D05A8B06
              AC851E8F25DD0CE2C47A947683B5DD6C3803C0F919106BD32D190FE09703F34E
              95674F0640064495F7767D44457EBF2A89402F67A168038D1AAEB45249B1333D
              2223115F14D3CD00E02A8115C90884ED8F3E050688CE43691B17CF178A7541CC
              28446EFF6C52E58F25F3648ADD1A00119D86549A01A0D050A89AB41E7E16D8AC
              5F03C0EFE36F0A5D6B6F4E796204006B7C33D6F7349881B0D6CC52A829E8A974
              A9974A47003CF7A31B54160469D627815170FAFB45B7228F0050FD68CE10B8DF
              EB753220C8F518A422A4D0561FBA341A01803E4DE9210F13C5AEA2785B6B0D83
              07A15129067E9BD5D3A6EA00206816DF1A1D4263F73CE039989D20CCE854F144
              4A872C801B850BC85E20760590EA4B8C79F70041FC1187BE069DF062D603590A
              D9C3B782D8E40114B141BC0600676C01E10184341EA5510BE0C9727FAD046194
              0EF95FB68BA5763C5D9B85D8670B59B515F040D778C2B6F0DDE7575A896E3F92
              744B05840FE06E5B3D02903E2409A012139E3EDD2C386BA76D574839E7A0B5F7
              DF4A4CD8E70EE93B03E0330134A0ADD82A333AD9567C9801670022B767FAA20C
              C00C083A58E8D4950C006281D477615615335ABB353310D323330038247A81F1
              AF3C31049105C021D174823B33296E6D60C3753F4AAC14BBF460AB592102C1CD
              099E72E9C90A8A73DBC300BDE170AA62573CD094E3A201776D4CF01B5EA07AF3
              612CE8A76AC412331FE8C8195EF13618B673A12988350050962933D6F3C3D9AC
              07FC3A723DA3134097027B2D80A600D6E481D170360386614134D54E83D80AC0
              0281167C6660DA740F25476F603C88F03DC15E00ACB5DBFB31FB62036AD84FC6
              3BB688AE9A0B651F72E875C3776587F0C0A1019D38FFDC03F803CD5D1840BB53
              92260000000049454E44AE426082}
          end>
      end
      item
        Name = 'timer_FILL0_wght500_GRAD0_opsz48'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE900000365494441546843ED99F1B14E3110C5
              CFAB0015A00254800A50013AA00254800A50012A4005A80015A002E63793CCEC
              EC97DCEC26F7FEF166DECEDC79F3EE974DF6EC9EDD6C72CF74CEE56C27FB2F4B
              BA919CEBBBA43F499D93E17B01B823E953D298BB923E27752E00F41C76EE23B0
              CA8469FDBD7260DA8055C50B00C6833725DD96745F126595FFADFC94C443E5F9
              28E9DBAAF7D1DF2302CF243D92742D6910609E1730ADFD80C2302CB32B001E16
              03B2867B9C18FF54D25BF3C39BE294C7EEFD2EFB00F4782F090FB5C4D2A3D2A4
              D289BFF73A7A1F2461F0CB627C1DF64012BF35251B010CC03B9EDF5F24BD2A21
              1FB5073800F04F4ACE58C3D0E5F72AB41B8CEDCE990180D1B40B76815F854636
              FC99542077C883AB0DA5A1F19924C6E8AF2E51430B04D03037C9EA9BC1EBA56A
              6D4E118D009EB79C7FE7781AB0733884285218AA008A866F19005C25B1AAC0F7
              5E02DBC530807D0199D1418FEA446E75651401C2FBC3F03E439B19009E4E242F
              549A4E62128C8DAA4AA6879F01C03ABEB37D5D2A56330AA308FC36DE8FD2C072
              384BA1962EEFAEF4A2B005809E860DABCAAD64FF321B815614BA3BF216005B15
              A8F7D99661050020E895EAFEC0EE8E434F640B80A5CF260F3B25621580752049
              0C8D5200FE99D19BFDC841003C859BCEEE4500BA503E67AACF1E49DCCA83660E
              F600F85296299F470168DA100510EA4B1C95567320C48228809908D8531A1525
              DBB18658B055856C12CF00E8E476F8B507904A6256B100864D55D8ACF840DF44
              A601AC72386E6A7B24E78F7AF29BDAC8BC07BAFDC8AAA50D7DBA5236D22A5D06
              6CE580AF022FCAF1EF007B4FA6F45D70B70A8EBA514BA3616FBE13327F06D9EC
              8247007C25A014D2191E29F54E28D4058C0030893FAB0E2F9B16D0B17700A0CA
              F0EC1D01402E704175C94C7CC4BEE0A3FDB7542136C1AE4400A0DCFA80B16724
              BCE75933E4A4280026F4659577DC18509D46B7713D0F92B09CB999DB4A78E3CC
              00E881A8B7CCF03523DC01E1007BD3877ED878066701A0C34183C4B639C17BA2
              C0252C0FD72F9EBBE412B76FE8D76F0816309C874ADD8BDC96776600300F5B3C
              DEABB70E19CFB7C652EBA151FAA3C72C806A04C94D345A97B31150440AC3871F
              327A93AD02B0402A354660B8E18026004F7BDC03D90B809D177A9198F63B1986
              92233CCB46DBC58E0010A1CE6E632E00ECE6CAC989FE034E7CC631D85A46E900
              00000049454E44AE426082}
          end>
      end>
    Left = 81
    Top = 176
  end
  object ActionList1: TActionList
    Left = 88
    Top = 232
    object actnAutoUpdate: TAction
      AutoCheck = True
      Caption = 'Enable timer and auto update ...'
      OnExecute = actnAutoUpdateExecute
      OnUpdate = actnAutoUpdateUpdate
    end
    object actnCustomRange: TAction
      Caption = 'actnCustomRange'
    end
  end
end
