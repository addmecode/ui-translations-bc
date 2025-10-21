// table 50103 "ADD_ExtTranslLine"
// {
//     Caption = 'Element Translation Line';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Extension ID"; Guid)
//         {
//             Caption = 'Extension ID';
//             TableRelation = ADD_ExtTranslSetupLine."Extension ID";
//             ValidateTableRelation = true;
//         }
//         field(2; "Trans Unit ID"; Text[250]) //TODO: encrypt
//         {
//             Caption = 'Trans Unit ID';
//             TableRelation = ADD_ExtTranslSetupLine."Trans Unit ID";
//             ValidateTableRelation = true;
//         }
//         field(3; "Target Language"; Text[250])
//         {
//             Caption = 'Target Language';
//             TableRelation = ADD_ExtTranslHeader."Target Language";
//             ValidateTableRelation = true;
//         }
//         field(4; "Object Type"; Text[30])
//         {
//             Caption = 'Object Type';
//             FieldClass = FlowField;
//             CalcFormula = Lookup(ADD_ExtTranslSetupLine."Object Type" Where(
//                 "Extension ID" = field("Extension ID"),
//                 "Trans Unit ID" = field("Trans Unit ID")));
//         }
//         field(5; "Object Name"; Text[250])
//         {
//             Caption = 'Object Name';
//             FieldClass = FlowField;
//             CalcFormula = Lookup(ADD_ExtTranslSetupLine."Object Name" Where(
//                 "Extension ID" = field("Extension ID"),
//                 "Trans Unit ID" = field("Trans Unit ID")));
//         }
//         field(6; "Element Type"; Text[250])
//         {
//             Caption = 'Element Type';
//             FieldClass = FlowField;
//             CalcFormula = Lookup(ADD_ExtTranslSetupLine."Element Type" Where(
//                 "Extension ID" = field("Extension ID"),
//                 "Trans Unit ID" = field("Trans Unit ID")));
//         }
//         field(7; "Element Name"; Text[250])
//         {
//             Caption = 'Element Name';
//             FieldClass = FlowField;
//             CalcFormula = Lookup(ADD_ExtTranslSetupLine."Element Name" Where(
//                 "Extension ID" = field("Extension ID"),
//                 "Trans Unit ID" = field("Trans Unit ID")));
//             //todo tu skonczylem
//         }
//         field(10; "Developer Note 1"; Text[250])
//         {
//             Caption = 'Developer Note 1';
//         }
//         field(11; "Developer Note 2"; Text[250])
//         {
//             Caption = 'Developer Note 2';
//         }
//         field(12; "Developer Note 3"; Text[250])
//         {
//             Caption = 'Developer Note 3';
//         }
//         field(13; "Developer Note 4"; Text[250])
//         {
//             Caption = 'Developer Note 4';
//         }
//         field(14; "Developer Note 5"; Text[250])
//         {
//             Caption = 'Developer Note 5';
//         }
//         field(20; "Xliff Note 1"; Text[250])
//         {
//             Caption = 'Xliff Note 1';
//         }
//         field(21; "Xliff Note 2"; Text[250])
//         {
//             Caption = 'Xliff Note 2';
//         }
//         field(22; "Xliff Note 3"; Text[250])
//         {
//             Caption = 'Xliff Note 3';
//         }
//         field(23; "Xliff Note 4"; Text[250])
//         {
//             Caption = 'Xliff Note 4';
//         }
//         field(24; "Xliff Note 5"; Text[250])
//         {
//             Caption = 'Xliff Note 5';
//         }
//         field(30; "Element Source Caption 1"; Text[250])
//         {
//             Caption = 'Element Source Caption 1';
//         }
//         field(31; "Element Source Caption 2"; Text[250])
//         {
//             Caption = 'Element Source Caption 2';
//         }
//         field(32; "Element Source Caption 3"; Text[250])
//         {
//             Caption = 'Element Source Caption 3';
//         }
//         field(33; "Element Source Caption 4"; Text[250])
//         {
//             Caption = 'Element Source Caption 4';
//         }
//         field(34; "Element Source Caption 5"; Text[250])
//         {
//             Caption = 'Element Source Caption 5';
//         }
//     }
//     keys
//     {
//         key(PK; "Extension ID", "Trans Unit ID", "Target Language")
//         {
//             Clustered = true;
//         }
//     }

//     procedure GetDeveloperNotes(): Text
//     begin
//         exit(Rec."Developer Note 1" + Rec."Developer Note 2" + Rec."Developer Note 3" + Rec."Developer Note 4" + Rec."Developer Note 5");
//     end;

//     procedure GetXliffNotes(): Text
//     begin
//         exit(Rec."Xliff Note 1" + Rec."Xliff Note 2" + Rec."Xliff Note 3" + Rec."Xliff Note 4" + Rec."Xliff Note 5");
//     end;

//     procedure GetElementSourceCaptions(): Text
//     begin
//         exit(Rec."Element Source Caption 1" + Rec."Element Source Caption 2" + Rec."Element Source Caption 3" + Rec."Element Source Caption 4" + Rec."Element Source Caption 5");
//     end;
// }
