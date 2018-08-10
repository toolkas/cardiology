﻿using System.Windows.Forms;
using Cardiology.Model;

namespace Cardiology
{
    public partial class UrineAnalysisControl : UserControl, IDocbaseControl
    {
        private string objectId;
        private bool isEditable;

        public UrineAnalysisControl(string objectId, bool additional)
        {
            this.objectId = objectId;
            this.isEditable = !additional;
            InitializeComponent();
            initControls();

        }

        private void initControls()
        {
            DataService service = new DataService();
            DdtUrineAnalysis urineAnalysis = service.queryObjectById<DdtUrineAnalysis>(DdtUrineAnalysis.TABLE_NAME, objectId);
            if (urineAnalysis != null)
            {
                colorTxt.Text = urineAnalysis.DssColor;
                erythrocytesTxt.Text = urineAnalysis.DssErythrocytes;
                leukocytesTxt.Text = urineAnalysis.DssLeukocytes;
                proteinTxt.Text = urineAnalysis.DssProtein;
                regularAnalysisBox.Text = "Анализы за " + urineAnalysis.RCreationDate.ToShortDateString();
            }
            colorTxt.ReadOnly = !isEditable;
            erythrocytesTxt.ReadOnly = !isEditable;
            leukocytesTxt.ReadOnly = !isEditable;
            proteinTxt.ReadOnly = !isEditable;
        }

        public void saveObject(DdtHospital hospitalitySession)
        {
            if (isEditable)
            {
                DataService service = new DataService();
                DdtUrineAnalysis urine = service.queryObjectById<DdtUrineAnalysis>(DdtUrineAnalysis.TABLE_NAME, objectId);
                if (urine == null)
                {
                    urine = new DdtUrineAnalysis();
                    urine.DsidHospitalitySession = hospitalitySession.ObjectId;
                    urine.DsidDoctor = hospitalitySession.DsidCuringDoctor;
                    urine.DsidPatient = hospitalitySession.DsidPatient;
                }
                urine.DssColor = colorTxt.Text;
                urine.DssLeukocytes = leukocytesTxt.Text;
                urine.DssErythrocytes = erythrocytesTxt.Text;
                urine.DssProtein = proteinTxt.Text;
                service.updateOrCreateIfNeedObject<DdtUrineAnalysis>(urine, DdtUrineAnalysis.TABLE_NAME, urine.ObjectId);
            }
        }
    }
}
