﻿using System.Collections.Generic;
using System.Windows.Forms;
using Cardiology.Model;

namespace Cardiology.Controls
{

    public partial class IssuedMedicineContainer : UserControl
    {
        private string medListId;
        private int counter = 0;

        public IssuedMedicineContainer()
        {
            InitializeComponent();
        }

        internal void Init(DataService service, DdtIssuedMedicineList medList)
        {
            if (medList != null)
            {
                medListId = medList.ObjectId;
                clearMedicine();
                List<DdtIssuedMedicine> med = service.queryObjectsCollectionByAttrCond<DdtIssuedMedicine>(DdtIssuedMedicine.TABLE_NAME, "dsid_med_list", medList.ObjectId, true);
                for (int i = 0; i < med.Count; i++)
                {
                    IssuedMedicineControl control = new IssuedMedicineControl(getNextIndex(), this);
                    control.Init(service, med[i]);
                    sizedContainer.Controls.Add(control);
                }
            }
        }

        internal void refreshData(DataService service, List<DdtCure> cures)
        {
            if (cures != null)
            {

                clearMedicine();
                foreach (DdtCure cure in cures)
                {
                    IssuedMedicineControl ctrl = new IssuedMedicineControl(getNextIndex(), this);
                    ctrl.refreshData(service, cure);
                    sizedContainer.Controls.Add(ctrl);
                }
            }

        }

        internal List<DdtIssuedMedicine> getIssuedMedicines()
        {
            DataService service = new DataService();
            List<DdtIssuedMedicine> result = new List<DdtIssuedMedicine>();
            for (int i = 0; i < sizedContainer.Controls.Count; i++)
            {
                IssuedMedicineControl control = (IssuedMedicineControl)sizedContainer.Controls[i];
                DdtIssuedMedicine medObj = control.getObject(service, medListId);
                if (medObj != null)
                {
                    result.Add(medObj);
                }
            }
            return result;
        }

        internal void clearMedicine()
        {
            foreach (IssuedMedicineControl med in sizedContainer.Controls)
            {
                med.removeBtn0_Click(null, null);
            }
            sizedContainer.Controls.Clear();
        }

        internal void addMedicineBox()
        {
            IssuedMedicineControl ctrl = new IssuedMedicineControl(getNextIndex(), this);
            sizedContainer.Controls.Add(ctrl);
        }

        private int getNextIndex()
        {
            return counter++;
        }

        internal void remove(int index)
        {
            foreach (IssuedMedicineControl med in sizedContainer.Controls)
            {
                if (med.getIndex() == index)
                {
                    sizedContainer.Controls.Remove(med);
                }
            }
        }
    }

}