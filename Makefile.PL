use 5.008005;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME           => 'Sparkey',
    VERSION_FROM   => 'lib/Sparkey.pm',
    PREREQ_PM      => { 'Test::More' => 0 },
    ABSTRACT_FROM  => 'lib/Sparkey.pm',
    AUTHOR         => [ 'Damien Krotkine', 'Emmanuel Peroumalnaik' ],
    LIBS           => ['-lsparkey'],
    DEFINE         => '',
    INC            => '-I.',
    OBJECT         => '$(O_FILES)',
);

