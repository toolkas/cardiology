using System.Collections.Generic;
using Cardiology.Data.Model2;

namespace Cardiology.Data.Commons
{
    public interface IDdtHolterService
    {
        IList<DdtHolter> GetAll();
    }
}
