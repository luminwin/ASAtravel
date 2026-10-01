ASA TRAVELING COURSE
Tree-Based Machine Learning Methods
Student materials

SLIDE GUIDE
ASAtravel_Slide_Guide.pdf is the reading copy.
ASAtravel_Slide_Guide.docx is the editable copy.

R CODE
Open the script for the module you are studying, or use ASAtravel_AllModules.R.
Run sections in slide order within each module. Some examples reuse fitted
objects from earlier sections. Package installation commands are commented;
run them separately when needed. Sampling and forest randomization mean that
numerical results can differ from the examples shown in the workshop.

The code index identifies each section by module, slide, topic, package,
dataset, and principal function. It also gives the section's line range in the
module script and in the master script. A runnable section contains R commands
and may depend on earlier setup. A reference section contains interface syntax
or optional commands that should be adapted before use.

Some analyses, including repeated high-dimensional fits, cross-validation,
subsampling, and time-localized importance, can require substantial computation.
The optional 70-gene signature comparison in Part III requires the reference
vector nms and the get.orgvimp() helper; its setup instructions accompany the
commented comparison block.
