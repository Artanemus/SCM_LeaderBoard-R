object LeaderBoard: TLeaderBoard
  Left = 0
  Top = 0
  Caption = 'SwimClubMeet LeaderBoard'
  ClientHeight = 703
  ClientWidth = 1271
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 19
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 130
    Width = 1265
    Height = 570
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1261
    ExplicitHeight = 569
    object frxPreview1: TfrxPreview
      Left = 0
      Top = 0
      Width = 1265
      Height = 570
      Align = alClient
      OutlineVisible = True
      OutlineWidth = 121
      ThumbnailVisible = False
      FindFmVisible = False
      UseReportHints = True
      HideScrolls = False
      ExplicitWidth = 1261
      ExplicitHeight = 569
    end
  end
  object RelativePanel1: TRelativePanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1265
    Height = 121
    ControlCollection = <
      item
        Control = scmProgressBar
        AlignBottomWithPanel = True
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = True
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = lblMessage
        Above = scmProgressBar
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = lblTimeStamp
        Above = scmProgressBar
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = True
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = FlowPanel1
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = True
        AlignTopWithPanel = True
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = FlowPanel2
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = True
        AlignRightWithPanel = False
        AlignTopWithPanel = True
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = DBtxtSwimClubCaption
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = True
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = DBtxtSwimClubNickName
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = DBtxtSwimClubCaption
      end
      item
        Control = DBtxtStartOfSwimSeason
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = DBtxtSwimClubNickName
      end>
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 1261
    DesignSize = (
      1265
      121)
    object scmProgressBar: TProgressBar
      Left = 0
      Top = 105
      Width = 1265
      Height = 16
      Position = 100
      TabOrder = 0
    end
    object lblMessage: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 83
      Width = 211
      Height = 19
      Margins.Left = 10
      Anchors = []
      Caption = 'Only timed events are scored.'
    end
    object lblTimeStamp: TLabel
      AlignWithMargins = True
      Left = 1169
      Top = 83
      Width = 86
      Height = 19
      Margins.Right = 10
      Alignment = taRightJustify
      Anchors = []
      Caption = 'Time Stamp'
    end
    object FlowPanel1: TFlowPanel
      Left = 963
      Top = 0
      Width = 302
      Height = 56
      BevelOuter = bvNone
      FlowStyle = fsRightLeftTopBottom
      TabOrder = 1
      DesignSize = (
        302
        56)
      object spbExportPDF: TSpeedButton
        Left = 254
        Top = 0
        Width = 48
        Height = 48
        Action = actnExportPDF
        Anchors = [akTop, akRight]
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
      end
      object spbPrintReport: TSpeedButton
        Left = 206
        Top = 0
        Width = 48
        Height = 48
        Action = actnPrint
        Anchors = [akTop, akRight]
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
      end
      object spbUpdateTimer: TSpeedButton
        Left = 158
        Top = 0
        Width = 48
        Height = 48
        Anchors = [akTop, akRight]
        ImageIndex = 0
        ImageName = 'clock'
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
      end
      object spbRefresh: TSpeedButton
        Left = 110
        Top = 0
        Width = 48
        Height = 48
        Action = actnRefresh
        AllowAllUp = True
        Anchors = [akTop, akRight]
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
      end
      object spbAbout: TSpeedButton
        Left = 62
        Top = 0
        Width = 48
        Height = 48
        Action = actnAbout
        AllowAllUp = True
        Anchors = [akTop, akRight]
        Images = VirtualImageList1
        Flat = True
        Layout = blGlyphTop
        Margin = 0
      end
    end
    object FlowPanel2: TFlowPanel
      Left = 0
      Top = 0
      Width = 361
      Height = 56
      Anchors = []
      BevelOuter = bvNone
      TabOrder = 2
      object spbMenu: TSpeedButton
        Left = 0
        Top = 0
        Width = 48
        Height = 48
        ImageIndex = 0
        ImageName = 'outline_menu_black_48dp'
        Images = VirtualImageList2
        Flat = True
        OnClick = spbMenuClick
      end
      object spbMemberScores: TSpeedButton
        Tag = 1
        Left = 48
        Top = 0
        Width = 48
        Height = 48
        AllowAllUp = True
        GroupIndex = 2
        ImageIndex = 1
        ImageName = 'outline_people_alt_black_48dp'
        Images = VirtualImageList2
        Flat = True
        OnClick = spbGenericSPBtnClick
      end
      object spbHouseScores: TSpeedButton
        Tag = 2
        Left = 96
        Top = 0
        Width = 48
        Height = 48
        AllowAllUp = True
        GroupIndex = 2
        ImageIndex = 2
        ImageName = 'outline_home_black_48dp'
        Images = VirtualImageList2
        Flat = True
        OnClick = spbGenericSPBtnClick
      end
      object spbEventScores: TSpeedButton
        Tag = 3
        Left = 144
        Top = 0
        Width = 48
        Height = 48
        AllowAllUp = True
        GroupIndex = 2
        ImageIndex = 3
        ImageName = 'outline_pool_black_48dp'
        Images = VirtualImageList2
        Flat = True
        OnClick = spbGenericSPBtnClick
      end
      object spbCurrEventStatus: TSpeedButton
        Tag = 4
        Left = 192
        Top = 0
        Width = 48
        Height = 48
        AllowAllUp = True
        GroupIndex = 2
        ImageIndex = 4
        ImageName = 'outline_leaderboard_black_48dp'
        Images = VirtualImageList2
        Flat = True
        OnClick = spbGenericSPBtnClick
      end
      object spbCurrEventStatus2: TSpeedButton
        Tag = 4
        Left = 240
        Top = 0
        Width = 48
        Height = 48
        AllowAllUp = True
        GroupIndex = 2
        ImageIndex = 4
        ImageName = 'outline_leaderboard_black_48dp'
        Images = VirtualImageList2
        Flat = True
        OnClick = spbGenericSPBtnClick
      end
    end
    object DBtxtSwimClubCaption: TDBText
      AlignWithMargins = True
      Left = 551
      Top = 10
      Width = 163
      Height = 19
      Margins.Top = 10
      Alignment = taCenter
      Anchors = []
      AutoSize = True
      DataField = 'Caption'
    end
    object DBtxtSwimClubNickName: TDBText
      AlignWithMargins = True
      Left = 542
      Top = 42
      Width = 180
      Height = 19
      Margins.Top = 10
      Alignment = taCenter
      Anchors = []
      AutoSize = True
      DataField = 'NickName'
    end
    object DBtxtStartOfSwimSeason: TDBText
      AlignWithMargins = True
      Left = 560
      Top = 74
      Width = 144
      Height = 16
      Margins.Top = 10
      Alignment = taCenter
      Anchors = []
      AutoSize = True
      DataField = 'CaptionStr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object ActionManager1: TActionManager
    Images = VirtualImageList1
    Left = 472
    Top = 200
    StyleName = 'Platform Default'
    object actnMenu: TAction
      Caption = 'actnMenu'
      Hint = 'Menu and options'
    end
    object actnMember: TAction
      Caption = 'actnMember'
      GroupIndex = 1
      Hint = 'A list of total points for each entrants (decending).'
    end
    object actnHouse: TAction
      Tag = 1
      Caption = 'actnHouse'
      GroupIndex = 1
      Hint = 'The club'#39's house leaderboard.'
    end
    object actnEvents: TAction
      Tag = 2
      Caption = 'actnEvents'
      GroupIndex = 1
      Hint = 'A list of closed events with entrant'#39's place & points.'
    end
    object actnSession: TAction
      Tag = 3
      Caption = 'Session'
      GroupIndex = 1
      Hint = 'The last closed event in detail.'
    end
    object actnRefresh: TAction
      Caption = 'Refresh'
      Hint = 'Refresh the leaderboard.'
      ImageIndex = 3
      ImageName = 'refresh'
      OnExecute = actnRefreshExecute
      OnUpdate = actnRefreshUpdate
    end
    object actnPrint: TAction
      Caption = 'Print Report'
      Hint = 'Print the currently viewed report.'
      ImageIndex = 1
      ImageName = 'print'
      OnExecute = actnPrintExecute
      OnUpdate = actnPrintUpdate
    end
    object actnExportPDF: TAction
      Caption = 'Export PDF'
      Hint = 'Export the current viewed report to a PDF to file.'
      ImageIndex = 2
      ImageName = 'PDF'
      OnExecute = actnExportPDFExecute
      OnUpdate = actnExportPDFUpdate
    end
    object actnTimer: TAction
      Caption = 'Timer'
      Hint = 'Set the timer for auto-refresh'
      ImageIndex = 0
      ImageName = 'clock'
    end
    object actnAbout: TAction
      Caption = 'About'
      ImageIndex = 4
      ImageName = 'Info'
      OnExecute = actnAboutExecute
    end
  end
  object Timer1: TTimer
    Enabled = False
    Left = 472
    Top = 272
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'clock'
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
        Name = 'print'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001424944415478DAEDDA3D0E823000C5F1770717E3C79D583903265E88
              991318CF62E2686473D11553070D09AD864AA014FD3F3693D2F7436808201142
              08218410FF9881370000000000302D406CFB030000000000000000E82F6B65DA
              E9A8DBE03771F676D3513B655A772FBF54AE2A78717BAB946BD9A57E32C251FF
              FC6F24DFD6DFEA1E4D7D23A3BBB6DF1DFDB8EA3F0989FFB97F8DAEBE91D1D5F7
              5AC8A3AC6F6494FB2D9C55B480CA6751DD38C34E4A350FFE0C76AE5427A7CBA6
              7DE0DEA93F1BED41F2CC21ECDB071DAC2169B0BA2B152A55AAD0AAFE2DB5DA1C
              DA7763AF408B60F52FF59C979AB07056A2F8EE0E5F291AB316DDFB8C05383766
              3D03E014EAE7229E10E0FD323A29404F7D7E1E10FA05070000000000181730F4
              8BE9DEE7030000000000837E4FC45B4A0000000000C097BB00000000F0BF0042
              08218490DFC9035B33EF09195405090000000049454E44AE426082}
          end>
      end
      item
        Name = 'PDF'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600803000000D54687
              0A00000033504C54450000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000000A30546C9
              0000001174524E53002A8ED5F2FF0592FCBA91D4E6A51BECE5437123D6000000
              EA494441547801EDD90592C3401043D136C84CF7BFECA20A03862E2DEA05A7E8
              87A127CCECB9A2AC6A9C54576511C7346D874BBAB689039A1E97F5470A031286
              D8557448E88AD85322A58C3D2352C6D85323A58E3DA03809F41B030E380072C0
              81FB1C004DF312CFD69900ADCBB3752A40F3B3752A40DBB3752A70E4D2016D80
              B6FB01C1CB5414581769801F0D9A40D0F127D90175803675601607D64510B8FF
              BEF0CF16077E55C00107640329906CA406920D0541B2B12648369805C946CB20
              D9701C241BEF8342E0B7041C70A0464EEC19D581521D283A598006A4E8B61649
              B7394A89EDDD6CC0CC5E01DC3E3F10D258D0C40000000049454E44AE426082}
          end>
      end
      item
        Name = 'home'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000001CD4944415478DAED98AD6E024114852F21152455884A4C2DAEBAB22F
              B0B26F80ED23A0FB06B5BC402DBE0E5D83ADC091601A9292ED1D12C8027377EF
              ECCFCCDDE47CC7B033B3EC3D982F2C110000000000E88601BD73067D1DFF8E16
              947316FCA987DCD3F238BECB92AF7AC603ADCEE3BBAC78A5473CD2FA627C9735
              AFF68427DADC8CEFB2E19D1EF0423BEFF82E3BDE35CE2BEDC5F15DF67CC2306F
              74281DDFE5C0A7CC4A2B57C6A0DC4ED2BACE2FC7B76E4C6E456915B3A567CED6
              BB67486ED7D23AE587A6C7FD297FF2ED1B919B4F5A2EDF34399F99F095EF8C01
              B949D2FAA2F1C5B931AF18949B24AD4F1ADD9C1DF1AA31B949D2FAA0A1F7FC90
              770CC94D92D6BCF4AEB90DB949D2FAA359E5BD333E95586EB2B432D5FD595AB9
              95494B4B42B955494B4B22B969A4A52581DCB4D2D212596E21D2D212516EA1D2
              D212496EF5A4A5A563B9359196960EE526492B574A4B4B263CA5A1DC2469B9B4
              8DF49C067293A415B7406DB949D28A5FA096DC2469A529102CB7B2D783690A04
              C9ADEAF5609A026AB9695E0FA629D0506E5505F2C0847E7FEBBF100AA0000AA0
              000A745AA0ED7D14400114400114400114400114400114B053A0E91F96D82FCE
              5000055000055000000000000000008AFC031C87CEBAB696E6E6000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'outline_leaderboard_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600103000000D856E5
              7B00000006504C5445000000000000A567B9CF0000000174524E530040E6D866
              000000294944415478016318ECE03F10D0850344C38003F7197D3810040434E6
              C010699C510E0CD09433980100DCDB46C8E41F69D30000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'outline_menu_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600103000000D856E5
              7B00000006504C5445000000000000A567B9CF0000000174524E530040E6D866
              0000001C4944415478016320138C02FEFF50F081961CF2C168188C86C1280000
              3628D729A23945180000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_people_alt_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B3000003804944415478DAED994D48545114C77F35918649B548B45CD4AAFCC8
              8D0519F441A043137D815B3741458B42A1A5104C34A9D042618602177D40B468
              1B6D1A06029568619895A0B6505B8AA69529E9B49846F4DEFBDE9BA7EF19F33A
              FFB39CFFBDE7FC9FE7DC7BEE1104028140201008040281602DD84A0371520C33
              CB2CC3A488D3C0564B7E01A7B9CB6B4672E4FB8A52E2CC9036D80C714A8D6B76
              32EE8AEF1B0A88F2DD187CD6BE13A5C0B032CC922BBE4FDFBECF36F8ACF519BF
              EB03977CCF51634C03B38D53A3AD2F66D215DFF3AF9F7BF89990F4AF7AC725DF
              D3DCEF73157E2631D4DC2EE1A72BBE8788BA0E3F4D9AA88B3A30F33D4299F1E4
              F9480B956C673B95B4F0D178C294293B9D7238C1CAFC1190D05C2D7083D02A4E
              881B2C68BC84968A3F6C2524FCB975A71537F3D41B99F5CC2BCC69EDB67D652B
              60DA8FDB39ACB9B969C9BDA971C30AE39643DD84BD1710D7723F64C90D69B510
              5718E71D04C4BD1790525C34DBB29B15764AF9FDA8838094F70286141755B6EC
              2A853DA4FCBEDF41C090F702D4CEB3D8965DAC759CAB51E420604604042F85F2
              BE88F3FE18CDFB8B2CEF5B89BC6FE602D04EE7FD8326004FCABC7FD40760AC12
              80C15600468B0118EE0662BC2E10FCCF08514D23AD74936490B1E5F3648C4192
              74D34A23D5360F1E15859CA1622302DF4184186F98CBE9229BE30D3122ECC861
              E74A3EF083777471895D7E845E4D94FE35F5A269D2BC27C631070F45BC5CE6F7
              738F235E857E90DB7C5A73E82BED2B1D1CB24DCC47ABF85F88ADAF37DA4223BD
              9E84BED27A69648BA5841786F9C43936B90F7E334D8C7A1E7CD6466962B38B17
              C7672EBB3812803A067C0B3E6B03D4197DEFD7860759FE895CFB9B4E167D0F3F
              4D9A453A8D7DD0350BFE125D143AF7983D39399F2449826622D4B28F7200CAD9
              472D119A4990B479B6ACB41E431F1A328E0632F6963DF6E18F38389CE0095773
              BC742AB8C263261C761C314868B2E5975B9FC403B60BDB1DCF72AB8A6A63D8B6
              1A8A9415DB2CEA2063831AFF2F3A2D16CCF39C93EBBE4F8EF38C5F161E3A35F6
              53DBBFDA43938303C6D29DA38312CFEEF3DDB41967728B1C5098D76D05FCA652
              DFBCDD407C649D6FEB98EF751B3CB52BACC30E95735FDF58ED7466B9E85B5378
              966F8AB77E85B1D741C0077DD3298572C1D7BE36A2789BD2CAD8F5BFA0548ADF
              70F2E77483880011E0B7808D361120024480081001FF56804020100804028140
              20F8DFF0073E8ED3890E222A580000000049454E44AE426082}
          end>
      end
      item
        Name = 'outline_pool_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000600000006008040000004891BF
              B30000042C4944415478DAED9B5D6C544514C77F6D691128FDD4826F46591B21
              114CA351420C044313C383550B62CA47FC201AB12D20494302554BD2B02FF054
              02824D21C5071313CA935852518210055225B1AE0B1B2AB5B6B594D0A4DDB684
              E1A125C0EEDE3B337769E7AECE7F5EF79C39BFDD9DF3716717ACACACACACACAC
              ACACE412084689F0076D1CA58E37284ED26326E51C21C420838438423999930D
              10BB3AD94F29699EFC95118EF317A66C6A01C657882A6668F94A27E8E82D48FA
              5403080411DED4F01574F515340120101CA740F1CB23F354660640709597148E
              6E58EA273C19C75928AD61E9BB57AEE4A7DC1480E016EFBAFA6956F2D26C0E40
              709B4D2E7E3A947C7498047047B8A9E4E1E6E464A25C022CE5431AF8DD338251
              80FB358F3AFA5C113EF6D757289166B093214D046387D8494FF28B4B2095FE49
              A3CE9A4EA30682B142E6AEDD1A08865A09996A35108C34730F13C1483B9D2C42
              95E981E6E1234CF148993C80A0DAEF837FAD34BF54A776F8BE46A855EE5537A7
              76F8BE44D00B5F20D892DAE1FB0AC15BF8BE41F01EBE40B035B5C3378E907CF8
              02C127A91DBE3104F7F0AFF315EFB1887C208B277881F51CA6C74F088B69717C
              D8BE914712DA64B1964B0E56A5263E852571E3FC0055929638830FE21EC6B4B3
              CCD43948670DDFD28D60908B7CCA634A5679D4708E1B08FEE1046BC9C0CACACA
              EA3FAB4C96534F2B97E94730428863544AEFE88BA8A091B3448822E8E7020758
              4D9EC4EA59B6719C4B5C9BB8443FC967BC9C4C92CDA6862E87CA798A950E560B
              686224A1CD10FB782AA14D1AABF8D961A72B54335D3FF83436D02D69C2DA5818
              6355400363AE362304C989B17A9173D26BF4553AA10758C779C51BC9A3943217
              98CD737CCEBF4A563DD4B2886CE0715EE56B6E2B599DA582792ABFCB10BE5E7D
              16C002180018A09EE7C9018A788526499EB9D7E5BFC3D364904E80F5CA49A199
              15CC017228A12E4152D006B8C517715DFE7C4E4802E96563DC3D4B057F49AC4E
              53126393CF5E46BD0344696481C3AB4A697508A39B1DE426B499C9563A1DACCE
              F0BAC34EC51C6458076098083F7188B77954F2CA001FF10D1D44115CE70A27D9
              CD0AB25C6DA6B18C5D7C3FF16974F21B2D6C61BE64A702DEE22017E85501B0B2
              B2B2F293C6D3DE7784E94330CA9F4A692F9FD51CE00C118610DCA09D462A2892
              581553C931DAB98A40D0C50FD4B33C99CBEF596CF3507802ECBFAFF03C38CC34
              3916C6959C72D8A98B1AB2BD4D647F6B97FE3CF6C494FED835C63E0AE366E136
              C94EDD6C50FF89B9DE4476B7F99AC54276D2AB6435DE1CE64E348787159BC3F3
              AC2390FA1399B00016C000403F7594305BF3D04DCE44A60D304643DCDF1AE469
              AF87F73D4C643F2A4C645A0051BEE4190F85677BDCB337F944769AD75C26B2A8
              0EC0BD89AC50A9F4871841D0CF655A154A7FEC44F62B2D6C767C9BEEAA90351C
              E222032A005656565656565656FF1FDD01574E4866331FE1590000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'refresh'
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
        Name = 'Info'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000017352474200AECE1CE90000042E494441546843ED9947A815491486
              3FB72E0C881B130AAE467414845117868563449C3163405147174E7010441046
              712328C6013161CE19CC2E745C184031A12B41316D440C0BD7F20F558FBA7DBB
              6F5755973E1E78A0B9977BEB9C3A7F8513FE6E450B97562DDC7FBE0368EE1D4C
              B9035D8021407FA0BBF308E373E7B903FC07BC4A01BE2A801F8079C020E0A740
              876E0337801DC09340DDA6E1B100DA007F038B017DAF229F80F5C03A40DF8324
              06C04C6029D02B33D353E000F0D21C0FFBA9613A5E5D9DCFE940CF8CFE63602D
              B03B044128800DC09F9909AE03FB8DF39F3D276F0D08C40C6070464700E678DA
              090AA3E781518EE177C002E084EF6405E326005B810ECEFFBAF43D7CECFAEEC0
              26E077C7E023606A95CB97714EC1E030D0DBF9FDAE89680D71F800F8CDAC9035
              740C98ECB33A11638E02931CBD65C0EA4676CA004C312B636DFC9BD989081F4B
              5536038B9C51BA2B078BB41A015078549CB6D1E60AF073E9F469065C06861B53
              8A4ECA33B921B6118015C03FC68842E240E0751AFF4AAD74066E9AD0ABC12B01
              F95327450074A964C026A95F8153A5D3D60E9806FC627E92EEA1407DE99E343A
              5A7D2D605DC62E02A0CCF89751569C578D132A0AAF022E91230A97A1A29AC9E6
              09E52065FE1A2902700FE86B462A0A6D0F9D19980DEC327A4A4C4119D6E8CD07
              B699EFF7817E3E0054493E3303551EFC08F866D8ACFD8EE687B7110B201565EC
              074ED9A1E4A624D724793BE0AE5CE1E589742846CD0D26753B9907C03DFF2A15
              EC16C64C9E42C74DA475F7200F8022C67833F358E05C0A2F2AD818039C35FAA7
              9DC8F6FF4F7900DC0BDC0750DD13234381AB46F11A302CC688A98F1E165DE43C
              00EF817646419F1F23274E05A02DF0C1F8A0CFF66597D80520E5E02EC94C900A
              8092A95D442F00EE11521D14DBAFA602A0AA40F590A42E17945DE291C0A5663E
              4223808B2197D80DA3621C76363380B986B9901B5E6154F5B77A5C49954496EA
              08B9894C3DB4888326C93B426210543E4BAA94122900644B09311B3584585131
              77CB21AA628BB91400DC624E44D880EC712E022092C996AEB1E5740A006E39AD
              BB2932AD467C1B9A8911F4495500EA1F8E1B6F831B1AE9B997471C901A8B909C
              50058062BF76DE7245C12DA500649B7AD544AA8DBE85A8F6B11C5174532F47C5
              83EE753CFE9A9C909D26CB0DCD02F615AD5A192F24BD35C012C7C0D7E486B29C
              D046A737CFC5E003408A6780718E057144EA8E52D12CA251D43F5B2E48535D00
              46979D575F00B2B307D0765A51B213531D4AB7647D127DA2955692B2A29DF8A3
              CC79FD1F0240E317025B328653D3EB416D6C2800F92E567A7983171C6FCCD17A
              01E89174338F8E4A27F36E20EF05C72AE088CFCADB313100A4DBA25F31B90BA4
              84A37A4549CB1261BE0BA8E644BDB248B3900459633F7607F29C1421262022C2
              1ABD66155125C76B082A5FD4D9712901C4FA5049EF3B804ACB9740B9C5EFC017
              4EABDD310AD690EA0000000049454E44AE426082}
          end>
      end>
    Left = 472
    Top = 344
  end
  object VirtualImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'clock'
        Name = 'clock'
      end
      item
        CollectionIndex = 1
        CollectionName = 'print'
        Name = 'print'
      end
      item
        CollectionIndex = 2
        CollectionName = 'PDF'
        Name = 'PDF'
      end
      item
        CollectionIndex = 8
        CollectionName = 'refresh'
        Name = 'refresh'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Info'
        Name = 'Info'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 472
    Top = 408
  end
  object VirtualImageList2: TVirtualImageList
    Images = <
      item
        CollectionIndex = 5
        CollectionName = 'outline_menu_black_48dp'
        Name = 'outline_menu_black_48dp'
      end
      item
        CollectionIndex = 6
        CollectionName = 'outline_people_alt_black_48dp'
        Name = 'outline_people_alt_black_48dp'
      end
      item
        CollectionIndex = 3
        CollectionName = 'home'
        Name = 'outline_home_black_48dp'
      end
      item
        CollectionIndex = 7
        CollectionName = 'outline_pool_black_48dp'
        Name = 'outline_pool_black_48dp'
      end
      item
        CollectionIndex = 4
        CollectionName = 'outline_leaderboard_black_48dp'
        Name = 'outline_leaderboard_black_48dp'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 472
    Top = 472
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 632
    Top = 360
  end
end
