Name:       ru.yurasov.simpleradio
# >> macros
# << macros

Summary:    Простое онлайн радио
Version:    1.0
Release:    2
Group:      Qt/Qt
License:    GPL
URL:        https://github.com/leonidy-85/ru.yurasov.simpleradio

Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(auroraapp)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)

%description
Простое онлайн радио

%prep
%setup -q -n %{name}.%{version}

%build
%qmake5
%make_build

%install
rm -rf %{buildroot}
%qmake5_install

%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%defattr(644,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png

%clean
rm -f translations/*.qm
rm -f *.o
rm -f moc_*
rm -f documentation.list
rm -f qrc_resources.*
rm -f Makefile
