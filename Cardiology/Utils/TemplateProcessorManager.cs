﻿using System.Collections.Generic;

namespace Cardiology.Utils
{
    class TemplateProcessorManager
    {
        private static List<ITemplateProcessor> processors = new List<ITemplateProcessor> { new FirstInspectationTemplateProcessor(), new JournalTemplateProcessor()};

        public static ITemplateProcessor getProcessorByObjectType(string type)
        {
            foreach(ITemplateProcessor proc in processors)
            {
                if (proc.accept(type))
                {
                    return proc;
                }
            }
            return null;
        }
    }
}