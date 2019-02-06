﻿using System.Windows.Forms;
using Cardiology.Model;
using Cardiology.Utils;

namespace Cardiology.Controls
{
    public partial class XRayControl : UserControl, IDocbaseControl
    {
        private string objectId;
        private bool isEditable;
        private bool hasChanges;
        private bool isNew;

        public XRayControl(string objectId, bool additional)
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
            DdtXRay xRay = service.queryObjectById<DdtXRay>(objectId);
            refreshObject(xRay);
            chestXRayTxt.Enabled = isEditable;
            controlRadiographyTxt.Enabled = isEditable;
            ktTxt.Enabled = isEditable;
            mrtTxt.Enabled = isEditable;
        }

        public string getObjectId()
        {
            return objectId;
        }

        public void saveObject(DdtHospital hospitalitySession, string parentId, string parentType)
        {
            if (isEditable && (isNew && getIsValid()|| isDirty()))
            {
                DataService service = new DataService();
                DdtXRay xRay = (DdtXRay) getObject();
                xRay.DsidHospitalitySession = hospitalitySession.ObjectId;
                xRay.DsidDoctor = hospitalitySession.DsidCuringDoctor;
                xRay.DsidPatient = hospitalitySession.DsidPatient;
                if (parentId != null)
                {
                    xRay.DsidParent = parentId;
                }
                if (parentType != null)
                {
                    xRay.DssParentType = parentType;
                }
                objectId = service.updateOrCreateIfNeedObject<DdtXRay>(xRay, DdtXRay.TABLE_NAME, xRay.ObjectId);
                isNew = false;
                hasChanges = false;
            }
        }

        public bool getIsValid()
        {
            return CommonUtils.isNotBlank(chestXRayTxt.Text) || CommonUtils.isNotBlank(controlRadiographyTxt.Text) ||
                CommonUtils.isNotBlank(ktTxt.Text) || CommonUtils.isNotBlank(mrtTxt.Text);
        }

        public bool isDirty()
        {
            return hasChanges;
        }

        public object getObject()
        {
            DataService service = new DataService();
            DdtXRay xRay = service.queryObjectById<DdtXRay>(objectId);
            if (xRay == null)
            {
                xRay = new DdtXRay();
            }
            xRay.DssChestXray = chestXRayTxt.Text;
            xRay.DssControlRadiography = controlRadiographyTxt.Text;
            xRay.DssKt = ktTxt.Text;
            xRay.DssMrt = mrtTxt.Text;
            xRay.DsdtAnalysisDate = CommonUtils.constructDateWIthTime(ktDateTxt.Value, ktTimeTxt.Value);
            return xRay;
        }

        public void refreshObject(object obj)
        {
            if (obj != null && obj is DdtXRay)
            {
                DdtXRay xRay = (DdtXRay) obj;
                ktDateTxt.Value = xRay.DsdtAnalysisDate;
                ktTimeTxt.Value = xRay.DsdtAnalysisDate;
                chestXRayTxt.Text = xRay.DssChestXray;
                controlRadiographyTxt.Text = xRay.DssControlRadiography;
                ktTxt.Text = xRay.DssKt;
                mrtTxt.Text = xRay.DssMrt;
                objectId = xRay.ObjectId;
                isNew = CommonUtils.isBlank(objectId);
                hasChanges = false;
            }
        }

        public bool isVisible()
        {
            return true;
        }

        private void ktDateTxt_ValueChanged(object sender, System.EventArgs e)
        {
            hasChanges = true;
        }

        private void ControlTxt_TextChanged(object sender, System.EventArgs e)
        {
            hasChanges = true;
        }
    }
}