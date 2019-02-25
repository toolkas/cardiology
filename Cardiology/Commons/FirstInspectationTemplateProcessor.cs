﻿using Cardiology.Data;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Cardiology.Data.Model2;

namespace Cardiology.Commons
{
    class FirstInspectationTemplateProcessor : ITemplateProcessor
    {
        private const string TEMPLATE_FILE_NAME = "first_inspectation.doc";

        public bool accept(string templateType)
        {
            return "ddt_anamnesis".Equals(templateType);
        }

        public string processTemplate(string hospitalitySession, string objectId, Dictionary<string, string> aditionalValues)
        {
            Dictionary<string, string> values = null;
            if (aditionalValues != null)
            {
                values = new Dictionary<string, string>(aditionalValues);
            }
            else
            {
                values = new Dictionary<string, string>();
            }
            DdtAnamnesis anamnesis = service.queryObjectById<DdtAnamnesis>(objectId);
            values.Add("{allergy}", anamnesis.AnamnesisAllergy);
            values.Add("{complaints}", anamnesis.Complaints);
            values.Add("{anamnesis}", anamnesis.AnamnesisMorbi);
            values.Add("{chronicle}", anamnesis.AccompanyingIllnesses);
            values.Add("{epid}", anamnesis.AnamnesisEpid);
            values.Add("{alco}", anamnesis.DrugsIntoxication);
            values.Add("{st_presens}", anamnesis.StPresens);
            values.Add("{respiratory_system}", anamnesis.RespiratorySystem);
            values.Add("{cardiovascular}", anamnesis.CardiovascularSystem);
            values.Add("{digestive_system}", anamnesis.DigestiveSystem);
            values.Add("{urinary_system}", anamnesis.UrinarySystem);
            values.Add("{nervous_system}", anamnesis.NervousSystem);
            values.Add("{past_surgeries}", anamnesis.PastSurgeries);
            values.Add("{operation_cause}", anamnesis.OperationCause);
            values.Add("{diagnosis}", anamnesis.Diagnosis);
            values.Add("{justification}", anamnesis.DiagnosisJustification);

            DdvDoctor doc = service.queryObjectById<DdvDoctor>(anamnesis.Doctor);
            values.Add("{cardio}", doc.ShortName);

            DdtEkg ekg = service.queryObject<DdtEkg>(@"SELECT * from ddt_ekg WHERE dsid_hospitality_session='' and dsb_admission_analysis=true");
            values.Add("{analysis.ekg}", ekg == null ? "" : ekg.Ekg);

            StringBuilder builder = new StringBuilder();

            DdtIssuedMedicineList medList = service.queryObject<DdtIssuedMedicineList>(@"SELECT * FROM ddt_issued_medicine_list WHERE dsid_hospitality_session='" +
                hospitalitySession + "' AND dss_parent_type='ddt_anamnesis'");
            if (medList != null)
            {
                List<DdtIssuedMedicine> med = service.queryObjectsCollectionByAttrCond<DdtIssuedMedicine>(DdtIssuedMedicine.NAME, "dsid_med_list", medList.ObjectId, true);
                for (int i = 0; i < med.Count; i++)
                {
                    DdtCure cure = service.queryObjectById<DdtCure>(med[i].Cure);
                    if (cure != null)
                    {
                        builder.Append(cure.Name).Append('\n');
                    }

                }
            }
            values.Add("{issued_medicine}", builder.ToString());

            StringBuilder actionsBuilder = new StringBuilder();
            List<DdtIssuedAction> actions = service.queryObjectsCollectionByAttrCond<DdtIssuedAction>(DdtIssuedAction.NAME, "dsid_parent_id", objectId, true);
            for (int i = 0; i < actions.Count; i++)
            {
                actionsBuilder.Append(i + 1).Append(". ");
                actionsBuilder.Append(actions[i].Action).Append('\n');
            }
            values.Add("{issued_actions}", actionsBuilder.ToString());

            DdtHospital hospital = service.queryObject<DdtHospital>(@"SELECT * FROM ddt_hospital WHERE r_object_id='" + hospitalitySession + "'");
            values.Add("{date}", hospital.AdmissionDate.ToShortDateString() + " " + hospital.AdmissionDate.ToShortTimeString());

            return TemplatesUtils.fillTemplate(Directory.GetCurrentDirectory() + "\\Templates\\" + TEMPLATE_FILE_NAME, values);
        }
    }
}
