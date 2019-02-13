using System.Collections.Generic;
using Cardiology.Data.Model2;

namespace Cardiology.Data.Commons
{
    public interface IDdtUziService
    {
        IList<DdtUzi> GetAll();

        DdtUzi GetById(string id);
    }
}
