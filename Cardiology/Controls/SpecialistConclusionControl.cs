﻿using System.Windows.Forms;
using Cardiology.Model;
using Cardiology.Utils;

namespace Cardiology
{
    public partial class SpecialistConclusionControl : UserControl, IDocbaseControl
    {
        private string objectId;
        private bool isEditable;
        private bool hasChanges;
        private bool isNew;

        public SpecialistConclusionControl(string objectId, bool additional)
        {
            this.objectId = objectId;
            this.isEditable = !additional;
            InitializeComponent();
            initControls();
            hasChanges = false;
            isNew = CommonUtils.isBlank(objectId);
        }

        private void initControls()
        {
            DataService service = new DataService();
            DdtSpecialistConclusion specConclusion = service.queryObjectById<DdtSpecialistConclusion>(DdtSpecialistConclusion.TABLE_NAME, objectId);
            refreshObject(specConclusion);
            neurologTxt.ReadOnly = !isEditable;
            surgeonTxt.ReadOnly = !isEditable;
            neuroSurgeonTxt.ReadOnly = !isEditable;
            endocrinologistTx.ReadOnly = !isEditable;
            analysisDate.Enabled = isEditable;
        }

        public void saveObject(DdtHospital hospitalitySession, string parentId, string parentType)
        {
            if (isEditable && (isNew && getIsValid()|| isDirty()))
            {
                DataService service = new DataService();
                DdtSpecialistConclusion specConslusion = (DdtSpecialistConclusion) getObject();
                specConslusion.DsidHospitalitySession = hospitalitySession.ObjectId;
                specConslusion.DsidDoctor = hospitalitySession.DsidCuringDoctor;
                specConslusion.DsidPatient = hospitalitySession.DsidPatient;
                if (parentId != null)
                {
                    specConslusion.DsidParent = parentId;
                }
                if (parentType != null)
                {
                    specConslusion.DssParentType = parentType;
                }
                objectId = service.updateOrCreateIfNeedObject<DdtSpecialistConclusion>(specConslusion, DdtSpecialistConclusion.TABLE_NAME, specConslusion.ObjectId);
                isNew = false;
                hasChanges = false;
            }
        }

        public string getObjectId()
        {
            return objectId;
        }

        public bool getIsValid()
        {
            return CommonUtils.isNotBlank(neurologTxt.Text) ||CommonUtils.isNotBlank(surgeonTxt.Text) 
                ||CommonUtils.isNotBlank(neuroSurgeonTxt.Text) ||CommonUtils.isNotBlank(endocrinologistTx.Text);
        }

        public bool isDirty()
        {
            return hasChanges;
        }

        public object getObject()
        {
            DataService service = new DataService();
            DdtSpecialistConclusion specConslusion = service.queryObjectById<DdtSpecialistConclusion>(DdtSpecialistConclusion.TABLE_NAME, objectId);
            if (specConslusion == null)
            {
                specConslusion = new DdtSpecialistConclusion();
            }
            specConslusion.DssNeurolog = neurologTxt.Text;
            specConslusion.DssSurgeon = surgeonTxt.Text;
            specConslusion.DssNeuroSurgeon = neuroSurgeonTxt.Text;
            specConslusion.DssEndocrinologist = endocrinologistTx.Text;
            specConslusion.DsdtAnalysisDate = analysisDate.Value;
            return specConslusion;
        }

        public void refreshObject(object obj)
        {
            if (obj != null && obj is DdtSpecialistConclusion)
            {
                DdtSpecialistConclusion specConclusion = (DdtSpecialistConclusion)obj;
                neurologTxt.Text = specConclusion.DssNeurolog;
                surgeonTxt.Text = specConclusion.DssSurgeon;
                neuroSurgeonTxt.Text = specConclusion.DssNeuroSurgeon;
                endocrinologistTx.Text = specConclusion.DssEndocrinologist;
                title.Text = "Заключения специалистов за " + specConclusion.DsdtAnalysisDate.ToShortDateString();
                analysisDate.Value = specConclusion.DsdtAnalysisDate;
                objectId = specConclusion.ObjectId;
                isNew = CommonUtils.isBlank(objectId);
                hasChanges = false;
            }
        }

        public bool isVisible()
        {
            return true;
        }

        private void analysisDate_ValueChanged(object sender, System.EventArgs e)
        {
            hasChanges = true;
        }

        private void ControlTxt_TextChanged(object sender, System.EventArgs e)
        {
            hasChanges = true;
        }
    }
}
