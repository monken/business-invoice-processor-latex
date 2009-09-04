use Test::More;

use Business::Invoice;

ok( my $invoice = Business::Invoice->new(
        processor => 'LaTeX',
        items     => [ {
                quantity    => 2,
                price       => 3.5,
                title       => 'E-mail',
                description => "IMAP/POP3 Account \x{00AE}"
            },
            {   title => 'Domains',
                items => [ {
                        quantity => 3,
                        title    => 'google.com/net/org',
                        price    => 1.1
                    },
                    {   quantity => 2,
                        title    => 'yahoo.com/net',
                        price    => 1.2
                    } ]
            },
            {   quantity    => 3,
                price       => 2.2,
                title       => 'Webspace',
                description => 'Web-Starter: 40 MiB'
            },
        ],
        stash => {
            tax_rate  => 0.19,
            recipient => {
                title => 'Mr.',
                first_name => 'Moritz',
                last_name  => 'Onken',
                address    => 'Lombardstreet 22'
            },
            company => { name => 'Company Name' } }
    ),
    'instantiate object');

ok($invoice->process);

ok($invoice->write('test.pdf'));

`open test.pdf`;

done_testing;
